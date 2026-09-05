#!/usr/bin/env bash
# Create the layout used by this repository's Archinstall profiles: a 1 GiB
# EFI System Partition plus a Btrfs partition containing the required subvolumes.
# WARNING: this permanently erases every partition and filesystem on the disk.
# Stop on errors, reject unset variables, and propagate pipeline failures.
set -euo pipefail

# The disk is always selected interactively below; do not accept a command-line
# device because this tool permanently destroys its target.
if [ "$#" -ne 0 ]; then
  echo "Usage: $(basename "$0")" >&2
  exit 2
fi

# Re-run this script as root when it was launched by a normal user. `exec`
# replaces this process so the rest of the script has the needed privileges.
if [ "$(id -u)" -ne 0 ]; then
  exec sudo -- "$0"
fi

# Find the parent disk of the filesystem mounted at /. Refuse that disk so the
# script cannot wipe the operating system it is currently running from. The
# `|| true` fallbacks accommodate live environments where / is an overlay.
root_source=$(findmnt -nro SOURCE / 2> /dev/null || true)
root_disk=$(lsblk -dnro PKNAME "$root_source" 2> /dev/null || true)
# When / is mounted directly from a disk (rather than one of its partitions),
# PKNAME is empty, so use that disk's own name as the protected target.
if [ -z "$root_disk" ] && [ "$(lsblk -dnro TYPE "$root_source" 2> /dev/null || true)" = "disk" ]; then
  root_disk=$(lsblk -dnro NAME "$root_source")
fi

# Build the menu from whole disks only. Exclude the disk containing / and any
# disk with a mounted filesystem, since neither is safe to repurpose here.
available_disks=()
while IFS= read -r candidate; do
  candidate=$(readlink -f -- "$candidate") || continue
  if [ -n "$root_disk" ] && [ "$candidate" = "/dev/$root_disk" ]; then
    continue
  fi
  if lsblk -nrpo MOUNTPOINT "$candidate" | awk 'NF { found = 1 } END { exit !found }'; then
    continue
  fi
  available_disks+=("$candidate")
done < <(lsblk -dnpo NAME,TYPE | awk '$2 == "disk" { print $1 }')

if [ "${#available_disks[@]}" -eq 0 ]; then
  echo "No unmounted non-root disks are available to format." >&2
  exit 1
fi

# List enough detail to distinguish similarly sized disks, then accept only a
# numbered choice. `q` and an empty response cancel without modifying a disk.
echo "Available install drives:"
for index in "${!available_disks[@]}"; do
  printf '  %d) ' "$((index + 1))"
  lsblk -d -o NAME,SIZE,MODEL,SERIAL,TRAN "${available_disks[$index]}"
done
read -rp "Choose a drive [1-${#available_disks[@]}] (or q to cancel): " choice
case "$choice" in
  q | Q | '')
    echo "Cancelled."
    exit 0
    ;;
  *[!0-9]*)
    echo "Invalid drive selection." >&2
    exit 2
    ;;
esac
if [ "$choice" -lt 1 ] || [ "$choice" -gt "${#available_disks[@]}" ]; then
  echo "Invalid drive selection." >&2
  exit 2
fi
disk=${available_disks[$((choice - 1))]}

# Show hardware-identifying details, then require a target-specific phrase as
# a final confirmation before any destructive command is run.
echo "About to permanently erase: $disk"
lsblk -d -o NAME,MODEL,SERIAL,SIZE,TRAN "$disk"
read -rp "Type exactly 'ERASE $disk' to continue: " reply
if [ "$reply" != "ERASE $disk" ]; then
  echo "Cancelled."
  exit 1
fi

# Erase filesystem signatures and the existing GPT/MBR metadata. Then create
# a new GPT containing a 1 GiB EFI partition followed by a Btrfs partition
# that consumes the remainder of the disk.
wipefs --all --force "$disk"
sgdisk --zap-all "$disk"
sgdisk --clear \
  --new=1:1MiB:+1GiB --typecode=1:ef00 --change-name=1:'EFI System' \
  --new=2:0:0 --typecode=2:8300 --change-name=2:'Arch Linux' \
  "$disk"
partprobe "$disk"
udevadm settle

# Partition paths use a `p` separator on disks whose names end in a digit
# (NVMe, MMC, and loop devices), but not on names such as /dev/sda.
case "$disk" in
  *[0-9])
    efi_part="${disk}p1"
    btrfs_part="${disk}p2"
    ;;
  *)
    efi_part="${disk}1"
    btrfs_part="${disk}2"
    ;;
esac

# Format the boot partition for UEFI firmware and the second partition as the
# Btrfs filesystem that will hold the Arch installation.
mkfs.fat -F 32 -n EFI "$efi_part"
mkfs.btrfs -f -L Arch "$btrfs_part"

# Mount Btrfs briefly so its subvolumes can be created. The EXIT trap always
# unmounts it and removes the temporary mount point, including on an error.
mount_dir=$(mktemp -d "${TMPDIR:-/tmp}/arch-format.XXXXXX")
cleanup() {
  if mountpoint -q "$mount_dir"; then
    umount "$mount_dir"
  fi
  rmdir "$mount_dir" 2> /dev/null || true
}
trap cleanup EXIT
mount "$btrfs_part" "$mount_dir"

# These names match the Archinstall profiles: the OS, home, logs, package
# cache, and games can each be mounted independently or handled by snapshots.
btrfs subvolume create "$mount_dir/@"
btrfs subvolume create "$mount_dir/@home"
btrfs subvolume create "$mount_dir/@log"
btrfs subvolume create "$mount_dir/@pkg"
btrfs subvolume create "$mount_dir/@games"

# The temporary mount is no longer needed. Remove it before mounting the
# finished layout at /mnt for the rest of the Arch installation.
umount "$mount_dir"
rmdir "$mount_dir"
trap - EXIT

# /mnt is the standard installation target in the Arch live environment. Do
# not mount over another installation or over files that may be important.
: "${archmount:?archmount must be set before sourcing manipulate-disk.sh}"
if mountpoint -q "$archmount"; then
  echo "Refusing to mount over the existing mount point: $archmount" >&2
  exit 1
fi
if [ -e "$archmount" ] && find "$archmount" -mindepth 1 -maxdepth 1 -print -quit | grep -q .; then
  echo "Refusing to use non-empty installation target: $archmount" >&2
  exit 1
fi
mkdir -p "$archmount"

# If any mount below fails, undo the partially mounted install layout. Once
# every mount succeeds, remove this error trap so the layout remains mounted.
cleanup_install_mounts() {
  local target
  for target in \
    "$archmount/games" \
    "$archmount/var/cache/pacman/pkg" \
    "$archmount/var/log" \
    "$archmount/home" \
    "$archmount/boot" \
    "$archmount"; do
    if mountpoint -q "$target"; then
      umount "$target" || true
    fi
  done
}
trap cleanup_install_mounts ERR

# Mount the root subvolume first, then mount the subvolumes at the paths that
# Archinstall expects. Compression matches the repository's disk profiles.
mount -o subvol=@,compress=zstd "$btrfs_part" "$archmount"
mkdir -p \
  "$archmount/boot" \
  "$archmount/home" \
  "$archmount/var/log" \
  "$archmount/var/cache/pacman/pkg" \
  "$archmount/games"
mount -o subvol=@home,compress=zstd "$btrfs_part" "$archmount/home"
mount -o subvol=@log,compress=zstd "$btrfs_part" "$archmount/var/log"
mount -o subvol=@pkg,compress=zstd "$btrfs_part" "$archmount/var/cache/pacman/pkg"
mount -o subvol=@games,compress=zstd "$btrfs_part" "$archmount/games"

# Mount the EFI System Partition where systemd-boot and the kernel will be
# installed. It is mounted last because its mount point lives in the root tree.
mount "$efi_part" "$archmount/boot"
trap - ERR

# Report the resulting partitions, subvolume layout, and live mount target.
echo "Done. Created $efi_part (EFI/FAT32) and $btrfs_part (Btrfs)."
echo "Btrfs subvolumes: @, @home, @log, @pkg, @games"
echo "Mounted installation layout at $archmount."
