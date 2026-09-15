#!/usr/bin/env bash
#
# install-arch.sh
# Interactive Arch Linux installer for use from the archiso live environment.
#
# Features:
#   - gum-driven prompts for hostname / admin user / password
#   - drive selection from a live list of block devices
#   - btrfs with 5 pre-configured subvolumes (@, @home, @snapshots, @var_log, @games) + zstd compression
#   - unified kernel image (UKI) built by mkinitcpio, auto-discovered by systemd-boot
#   - plymouth "bgrt" theme baked into the UKI, cmdline: "quiet splash"
#   - amd-ucode / intel-ucode auto-detected
#   - snapper + snap-pac timeline snapshots (no bootloader snapshot entries)
#   - zram via zram-generator (zstd)
#   - NetworkManager + iwd backend, live network profiles copied to the new install
#   - sudo NOPASSWD for wheel, admin user in wheel/input/video/scanner
#   - mDNS (avahi) + printing (cups)
#   - reflector-optimized mirrorlist
#   - chaotic-aur + yay, multilib, Color/ILoveCandy/ParallelDownloads=5
#
# Run this as root from the archiso live ISO with a working network connection.

set -euo pipefail

PS4='+ ${BASH_SOURCE##*/}:${LINENO}: '
# Session log; tee + xtrace are enabled after the interactive prompts (gum needs a
# real TTY on stdout/stderr, and passwords must not land in the log).
LOG=/var/log/arch-install.log

trap 'rc=$?; echo -e "\n[!] Failed on line ${LINENO} (rc=${rc}): ${BASH_COMMAND}\n    Nothing after that point was applied. Log: ${LOG}" >&2' ERR

start_logging() {
    exec > >(tee -a "$LOG") 2>&1
    if [[ -n "${INSTALL_DEBUG:-}" ]]; then set -x; fi
}

# --------------------------------------------------------------------------
# 0. Sanity checks + gum bootstrap
# --------------------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (it is meant to be run from the archiso live environment)." >&2
    exit 1
fi

if [[ ! -d /sys/firmware/efi/efivars ]]; then
    echo "This script only supports UEFI installs (systemd-boot requires UEFI)." >&2
    exit 1
fi

if ! command -v pacstrap &> /dev/null; then
    echo "pacstrap not found -- this script must be run from the archiso live environment." >&2
    exit 1
fi

source scripts/gum-helper.sh

# --------------------------------------------------------------------------
# 1. Gather input
# --------------------------------------------------------------------------

section "Arch Linux Install"

HOSTNAME=""
while [[ -z "$HOSTNAME" ]]; do
    HOSTNAME=$(gum input --placeholder "archlinux" --prompt "Hostname: ")
done

USERNAME=""
while [[ -z "$USERNAME" ]]; do
    USERNAME=$(gum input --placeholder "admin" --prompt "Admin username: " --value "kjm")
done

while true; do
    PASSWORD=$(gum input --password --placeholder "password" --prompt "Admin/root password: ")
    PASSWORD_CONFIRM=$(gum input --password --placeholder "confirm password" --prompt "Confirm password: ")
    if [[ -n "$PASSWORD" && "$PASSWORD" == "$PASSWORD_CONFIRM" ]]; then
        break
  fi
    warn "Passwords did not match (or were empty) -- try again."
done

section "Select install drive"
warn "ALL DATA on the selected drive will be permanently erased."

mapfile -t DRIVE_LIST < <(lsblk -dpno NAME,SIZE,MODEL | grep -Ev 'loop|sr0' || true)
if [[ ${#DRIVE_LIST[@]} -eq 0 ]]; then
    echo "No suitable block devices found." >&2
    exit 1
fi

DRIVE_CHOICE=$(printf '%s\n' "${DRIVE_LIST[@]}" | gum choose --header "Select a drive to install Arch Linux to:")
DISK=$(awk '{print $1}' <<< "$DRIVE_CHOICE")

if ! gum confirm "This will ERASE ALL DATA on ${DISK}. Continue?"; then
    echo "Aborted."
    exit 1
fi

# Partition suffix helper (nvme/mmcblk need a 'p' before the partition number)
part() {
    local d="$1" n="$2"
    if [[ "$d" =~ (nvme|mmcblk) ]]; then
        echo "${d}p${n}"
  else
        echo "${d}${n}"
  fi
}
ESP_PART=$(part "$DISK" 1)
ROOT_PART=$(part "$DISK" 2)

# Interactive prompts are done -- from here on, capture everything to the log.
start_logging

# --------------------------------------------------------------------------
# 2. Partition, format, subvolumes, mount
# --------------------------------------------------------------------------

section "Partitioning ${DISK}"

wipefs -af "$DISK"
sgdisk --zap-all "$DISK"
sgdisk -n1:0:+1GiB -t1:ef00 -c1:ESP "$DISK"
sgdisk -n2:0:0     -t2:8300 -c2:ArchRoot "$DISK"
partprobe "$DISK"
sleep 2

mkfs.fat -F32 -n ESP "$ESP_PART"
mkfs.btrfs -f -L ArchRoot "$ROOT_PART"

# Create 5 subvolumes:
#   @          -> /
#   @home      -> /home
#   @snapshots -> /.snapshots
#   @var_log   -> /var/log
#   @games     -> /games
mount "$ROOT_PART" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
btrfs subvolume create /mnt/@games
for sv in @ @home @snapshots @var_log @games; do
    btrfs subvolume show "/mnt/$sv" > /dev/null 2>&1 || {
                                                         echo "[!] btrfs subvolume $sv was not created" >&2
                                                                                                             exit 1
  }
done
umount /mnt

MOUNT_OPTS="noatime,compress=zstd,space_cache=v2,discard=async"

mount -o "${MOUNT_OPTS},subvol=@" "$ROOT_PART" /mnt
mkdir -p /mnt/{home,.snapshots,var/log,games,boot}
mount -o "${MOUNT_OPTS},subvol=@home"      "$ROOT_PART" /mnt/home
mount -o "${MOUNT_OPTS},subvol=@snapshots" "$ROOT_PART" /mnt/.snapshots
mount -o "${MOUNT_OPTS},subvol=@var_log"   "$ROOT_PART" /mnt/var/log
mount -o "${MOUNT_OPTS},subvol=@games"     "$ROOT_PART" /mnt/games
mount "$ESP_PART" /mnt/boot

require findmnt --noheadings /mnt
require findmnt --noheadings /mnt/home
require findmnt --noheadings /mnt/boot

ROOT_UUID=$(blkid -s UUID -o value "$ROOT_PART")

# --------------------------------------------------------------------------
# 3. Detect microcode + timezone
# --------------------------------------------------------------------------

CPU_VENDOR=$(grep -m1 vendor_id /proc/cpuinfo | awk '{print $3}')
if [[ "$CPU_VENDOR" == "GenuineIntel" ]]; then
    UCODE_PKG="intel-ucode"
else
    UCODE_PKG="amd-ucode"
fi
info "Detected microcode package: ${UCODE_PKG}"

DETECTED_TZ=$(curl -s --max-time 5 https://ipapi.co/timezone || true)
if [[ -z "$DETECTED_TZ" || ! -f "/usr/share/zoneinfo/$DETECTED_TZ" ]]; then
    DETECTED_TZ="America/New_York"
fi
info "Detected timezone: ${DETECTED_TZ}"

# --------------------------------------------------------------------------
# 4. pacstrap
# --------------------------------------------------------------------------

section "Installing base system"

PACKAGES=(
    # user-requested
    base base-devel pacman-contrib linux linux-firmware btrfs-progs
    plymouth man-db man-pages git wget curl chezmoi
    # required to support the requested features
    "$UCODE_PKG"          # microcode
    networkmanager iwd    # network
    avahi nss-mdns         # mdns
    cups                    # printing
    nfs-utils                # for the /mnt/NAS fstab entry
    ntfs-3g
    reflector                 # mirrorlist optimization
    zram-generator              # zram
    efibootmgr                    # bootloader (systemd-boot ships with systemd)
    sudo
    snapper snap-pac                # snapshots
    dosfstools mtools                  # ESP/FAT tooling
)

pacstrap -K /mnt "${PACKAGES[@]}"
require test -x /mnt/usr/bin/pacman

# --------------------------------------------------------------------------
# 5. fstab
# --------------------------------------------------------------------------

genfstab -U /mnt >> /mnt/etc/fstab
mkdir -p /mnt/mnt/NAS
printf '\n# NAS\n192.168.0.10:/mnt/md1 /mnt/NAS nfs defaults,nofail 0 0\n' >> /mnt/etc/fstab

# --------------------------------------------------------------------------
# 6. Copy live network configuration for first boot
# --------------------------------------------------------------------------

mkdir -p /mnt/var/lib/iwd
cp -a /var/lib/iwd/. /mnt/var/lib/iwd/ 2> /dev/null || true

mkdir -p /mnt/etc/NetworkManager/system-connections
cp -a /etc/NetworkManager/system-connections/. /mnt/etc/NetworkManager/system-connections/ 2> /dev/null || true
chmod 600 /mnt/etc/NetworkManager/system-connections/* 2> /dev/null || true

# --------------------------------------------------------------------------
# 7. Write variables + chroot configuration script
# --------------------------------------------------------------------------

{ set +x; } 2> /dev/null  # keep the password out of the xtrace log
cat > /mnt/root/chroot-vars.sh << EOF
HOSTNAME=$(printf '%q' "$HOSTNAME")
USERNAME=$(printf '%q' "$USERNAME")
USERPASS=$(printf '%q' "$PASSWORD")
UCODE_PKG=$(printf '%q' "$UCODE_PKG")
TZ_REGION=$(printf '%q' "$DETECTED_TZ")
ROOT_UUID=$(printf '%q' "$ROOT_UUID")
DISK=$(printf '%q' "$DISK")
INSTALL_DEBUG=$(printf '%q' "${INSTALL_DEBUG:-}")
EOF
chmod 600 /mnt/root/chroot-vars.sh
if [[ -n "${INSTALL_DEBUG:-}" ]]; then set -x; fi

cat > /mnt/root/chroot-setup.sh << 'CHSETUP'
#!/bin/bash
set -euo pipefail
PS4='+ chroot:${LINENO}: '
trap 'rc=$?; printf "\n[!] chroot-setup FAILED  line %s  rc %s  cmd: %s\n" "$LINENO" "$rc" "$BASH_COMMAND" >&2; exit $rc' ERR

source /root/chroot-vars.sh
if [[ -n "${INSTALL_DEBUG:-}" ]]; then set -x; fi

step()    { printf '\n==> %s\n' "$*" >&2; }
warn()    { printf '[!] %s\n' "$*" >&2; }
require() { "$@" || { printf '[!] REQUIRED step failed: %s\n' "$*" >&2; exit 1; }; }

# Run a non-essential step: log its failure, but never abort the install for it.
extra() {
    local desc="$1" rc=0; shift
    "$@" || rc=$?
    if [[ $rc -ne 0 ]]; then
        warn "[extra] ${desc} failed (rc=${rc}) -- continuing; fix it after first boot"
    fi
    return 0
}

step "Timezone + clock"
ln -sf "/usr/share/zoneinfo/$TZ_REGION" /etc/localtime
hwclock --systohc || warn "hwclock --systohc failed (no RTC?) -- continuing"
extra "enable systemd-timesyncd" systemctl enable systemd-timesyncd.service

step "Locale"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

step "Hostname"
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts <<HOSTS
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
HOSTS

step "Root + admin user"
getent group scanner >/dev/null || groupadd scanner
if id "$USERNAME" >/dev/null 2>&1; then
    usermod -aG wheel,input,video,scanner -s /bin/bash "$USERNAME"
else
    useradd -m -G wheel,input,video,scanner -s /bin/bash "$USERNAME"
fi
{ set +x; } 2>/dev/null   # keep passwords out of the xtrace log
echo "root:$USERPASS" | chpasswd
echo "$USERNAME:$USERPASS" | chpasswd
if [[ -n "${INSTALL_DEBUG:-}" ]]; then set -x; fi

mkdir -p /etc/sudoers.d
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
visudo -c

step "zram"
cat > /etc/systemd/zram-generator.conf <<ZRAM
[zram0]
zram-size = min(ram / 2, 8192)
compression-algorithm = zstd
ZRAM

step "NetworkManager / iwd"
mkdir -p /etc/NetworkManager/conf.d
cat > /etc/NetworkManager/conf.d/wifi_backend.conf <<NMCONF
[device]
wifi.backend=iwd
NMCONF
systemctl enable NetworkManager.service

step "mDNS"
sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns/' /etc/nsswitch.conf
extra "enable avahi-daemon" systemctl enable avahi-daemon.service

step "Printing"
extra "enable cups.socket" systemctl enable cups.socket

step "mkinitcpio -> Unified Kernel Image"
sed -i 's/^HOOKS=.*/HOOKS=(base systemd plymouth autodetect microcode modconf kms keyboard sd-vconsole block filesystems fsck)/' /etc/mkinitcpio.conf

mkdir -p /etc/kernel
echo "root=UUID=$ROOT_UUID rootflags=subvol=@ rw quiet splash" > /etc/kernel/cmdline

mkdir -p /boot/EFI/Linux
cat > /etc/mkinitcpio.d/linux.preset <<PRESET
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"

PRESETS=('default' 'fallback')

default_uki="/boot/EFI/Linux/arch-linux.efi"
default_options="--cmdline /etc/kernel/cmdline"

fallback_uki="/boot/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
PRESET

plymouth-set-default-theme bgrt

mkinitcpio -P
# UKI is self-contained; drop the loose vmlinuz/initramfs images so /boot only has the UKIs
rm -f /boot/vmlinuz-linux /boot/initramfs-linux.img /boot/initramfs-linux-fallback.img
require test -s /boot/EFI/Linux/arch-linux.efi
require test -s /boot/EFI/Linux/arch-linux-fallback.efi

step "systemd-boot bootloader"
bootctl install --esp-path=/boot

mkdir -p /boot/loader
cat > /boot/loader/loader.conf <<LOADERCONF
default      arch-linux.efi
timeout      1
console-mode keep
editor       no
LOADERCONF

# systemd-boot auto-discovers the UKIs in /boot/EFI/Linux -- no loader entries needed.
# Keep the EFI binary current on future systemd upgrades.
systemctl enable systemd-boot-update.service

require test -f /boot/EFI/systemd/systemd-bootx64.efi
require test -f /boot/EFI/BOOT/BOOTX64.EFI
require test -f /boot/loader/loader.conf

#  Remove all EFI boot entries before creating new one
for entry in $(efibootmgr | grep '^Boot[0-9]' | awk -F'[* ]' '{print substr($1,5)}'); do
  sudo efibootmgr -b "$entry" -B >/dev/null
done
efibootmgr --create --disk "$DISK" --part 1 --label "Linux Boot Manager" --loader '\EFI\systemd\systemd-bootx64.efi' --unicode \
    || warn "efibootmgr could not add an NVRAM entry -- the removable-media path EFI/BOOT/BOOTX64.EFI still boots"

step "Snapper (root config on the pre-created @snapshots subvolume, per Arch wiki procedure)"
setup_snapper() {
    if findmnt -M /.snapshots >/dev/null 2>&1; then
        umount /.snapshots 2>/dev/null || umount -l /.snapshots
    fi
    if [[ -e /.snapshots ]]; then
        btrfs subvolume delete /.snapshots 2>/dev/null || rm -rf /.snapshots
    fi
    snapper --no-dbus -c root create-config / || return 1
    [[ -e /.snapshots ]] && btrfs subvolume delete /.snapshots
    mkdir -p /.snapshots
    mount /.snapshots || return 1
    chmod 750 /.snapshots
    sed -i 's/^TIMELINE_CREATE=.*/TIMELINE_CREATE="yes"/'   /etc/snapper/configs/root
    sed -i 's/^TIMELINE_CLEANUP=.*/TIMELINE_CLEANUP="yes"/' /etc/snapper/configs/root
    systemctl enable snapper-timeline.timer snapper-cleanup.timer
}
extra "snapper root config" setup_snapper

step "Reflector"
mkdir -p /etc/xdg/reflector
cat > /etc/xdg/reflector/reflector.conf <<REFCONF
--save /etc/pacman.d/mirrorlist
--protocol https
--latest 20
--sort rate
REFCONF
extra "enable reflector.service" systemctl enable reflector.service
reflector --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist \
    || warn "reflector run failed -- keeping the mirrorlist from the ISO"

step "pacman.conf tweaks (Color, ILoveCandy, ParallelDownloads, multilib)"
sed -i 's/^#Color/Color/' /etc/pacman.conf
grep -q '^ILoveCandy' /etc/pacman.conf || sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
sed -i 's/^#\?ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf
sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf

step "Chaotic-AUR + yay"
setup_chaotic_aur() {
    local key=3056513887B78AEB ks
    local urls=(
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
        'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
    )
    for ks in keyserver.ubuntu.com keys.openpgp.org pgp.mit.edu; do
        pacman-key --recv-key "$key" --keyserver "$ks" && break
    done
    pacman-key --list-keys "$key" >/dev/null 2>&1 || return 1
    pacman-key --lsign-key "$key" || return 1
    pacman -U --noconfirm "${urls[@]}" || pacman -U --noconfirm "${urls[@]}" || return 1
    grep -q '^\[chaotic-aur\]' /etc/pacman.conf || cat >> /etc/pacman.conf <<CHAOTIC

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
CHAOTIC
    pacman -Sy --noconfirm || return 1
    pacman -S --noconfirm --needed yay || return 1
}
extra "chaotic-aur / yay" setup_chaotic_aur

step "Chroot configuration complete."
CHSETUP
chmod 700 /mnt/root/chroot-setup.sh

# --------------------------------------------------------------------------
# 8. Run the chroot script
# --------------------------------------------------------------------------

section "Configuring installed system (chroot)"
# tee so the chroot log survives into the target; pipefail still surfaces a failure.
arch-chroot /mnt /bin/bash /root/chroot-setup.sh 2>&1 | tee /mnt/var/log/arch-chroot-setup.log

rm -f /mnt/root/chroot-setup.sh /mnt/root/chroot-vars.sh

# RUN CHEZMOI
arch-chroot /mnt /bin/bash -c "sudo -H -u $USERNAME chezmoi init --branch hypr --apply kjmcnamara1"

# --------------------------------------------------------------------------
# 9. Done
# --------------------------------------------------------------------------

section "Install complete"
cp -f "$LOG" /mnt/var/log/arch-install.log 2> /dev/null || true
info "Unmounting..."
umount -R /mnt

cat << DONE

Arch Linux has been installed to ${DISK}.

Notes:
  - Bootloader: systemd-boot, auto-discovering UKIs from /boot/EFI/Linux (ESP mounted at /boot)
  - btrfs subvolumes: @, @home, @snapshots, @var_log, @games (compress=zstd)
  - Snapper is configured on the 'root' config with timeline snapshots +
    snap-pac pre/post pacman snapshots. There is no bootloader integration --
    restore a snapshot with 'snapper rollback' from a booted system or live ISO.
  - Wi-Fi/network profiles from the live session were copied over for first boot.
  - Admin user '${USERNAME}' has passwordless sudo via /etc/sudoers.d/wheel.
  - Non-essential steps (snapper, chaotic-aur/yay, avahi/cups, reflector) are
    best-effort: any '[extra] ... failed' lines above mean the system still boots
    but that piece needs finishing after first login.
  - Install logs: /var/log/arch-install.log and /var/log/arch-chroot-setup.log
    (in the installed system). Re-run with INSTALL_DEBUG=1 for a full trace.

You can now 'reboot'.
DONE
