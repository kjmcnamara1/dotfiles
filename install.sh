#!/usr/bin/env bash
# Install Arch Linux from the official ArchISO into a fresh UEFI/Btrfs layout.
set -euo pipefail

if [ "$(id -u)" -ne 0 ]; then
  exec sudo -- "$0" "$@"
fi

if [ ! -d /sys/firmware/efi/efivars ]; then
  echo "This installer requires an ArchISO booted in UEFI mode." >&2
  exit 1
fi

script_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)
archmount=/mnt

# gum provides the interactive controls; gptfdisk supplies sgdisk for the
# explicit GPT layout below. They are live-environment dependencies only.
pacman -Sy --needed --noconfirm gum gptfdisk

prompt_required() {
  local prompt=$1
  local value
  while :; do
    value=$(gum input --prompt "$prompt: ")
    if [ -n "$value" ]; then
      printf '%s\n' "$value"
      return 0
    fi
    gum style --foreground 196 "A value is required."
  done
}

prompt_password() {
  local prompt=$1
  local value
  while :; do
    value=$(gum input --password --prompt "$prompt: ")
    if [ -n "$value" ]; then
      printf '%s\n' "$value"
      return 0
    fi
    gum style --foreground 196 "A password is required."
  done
}

host=$(prompt_required "Hostname")
if [[ ! "$host" =~ ^[a-zA-Z0-9][a-zA-Z0-9.-]*$ ]]; then
  gum style --foreground 196 "Hostname may contain only letters, digits, dots, and hyphens."
  exit 2
fi
root_password=$(prompt_password "Root password")
admin_username=$(prompt_required "Admin username")
if [[ ! "$admin_username" =~ ^[a-z_][a-z0-9_-]*\$?$ ]]; then
  gum style --foreground 196 "Admin username is not a valid local Linux username."
  exit 2
fi
admin_password=$(prompt_password "Admin user password")

# Only present whole, unmounted, non-root disks. This prevents the live medium
# and any mounted data volume from being accidentally selected.
root_source=$(findmnt -nro SOURCE / 2>/dev/null || true)
root_disk=$(lsblk -dnro PKNAME "$root_source" 2>/dev/null || true)
if [ -z "$root_disk" ] && [ "$(lsblk -dnro TYPE "$root_source" 2>/dev/null || true)" = disk ]; then
  root_disk=$(lsblk -dnro NAME "$root_source")
fi

available_disks=()
while IFS= read -r candidate; do
  candidate=$(readlink -f -- "$candidate") || continue
  [ -n "$root_disk" ] && [ "$candidate" = "/dev/$root_disk" ] && continue
  if lsblk -nrpo MOUNTPOINT "$candidate" | awk 'NF { found = 1 } END { exit !found }'; then
    continue
  fi
  available_disks+=("$candidate")
done < <(lsblk -dnpo NAME,TYPE | awk '$2 == "disk" { print $1 }')

if [ "${#available_disks[@]}" -eq 0 ]; then
  gum style --foreground 196 "No unmounted non-root disks are available."
  exit 1
fi

drive_choices=()
for candidate in "${available_disks[@]}"; do
  drive_choices+=("$candidate  $(lsblk -dn -o SIZE,MODEL,SERIAL --noheadings "$candidate" | xargs)")
done
selected_drive=$(printf '%s\n' "${drive_choices[@]}" | \
  gum choose --header "Select the drive to erase and install Arch Linux on")
disk=${selected_drive%% *}

gum style --border normal --padding "1 2" --foreground 196 \
  "ALL DATA ON $disk WILL BE PERMANENTLY ERASED."
gum confirm "Erase $disk and install Arch Linux?" || exit 0

source "$script_dir/scripts/manipulate-disk.sh"
source "$script_dir/scripts/install-essential-packages.sh"
source "$script_dir/scripts/configure-locale.sh"
source "$script_dir/scripts/generate-fstab.sh"
source "$script_dir/scripts/configure-time.sh"
source "$script_dir/scripts/configure-hostname.sh"
source "$script_dir/scripts/configure-boot.sh"
source "$script_dir/scripts/configure-network.sh"
source "$script_dir/scripts/configure-users.sh"

gum style --foreground 10 "Installation complete. Reboot, remove the installation media, and boot Arch Linux."
