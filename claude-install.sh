#!/usr/bin/env bash
#
# install-arch.sh
# Interactive Arch Linux installer for use from the archiso live environment.
#
# Features:
#   - gum-driven prompts for hostname / admin user / password
#   - drive selection from a live list of block devices
#   - btrfs with 4 pre-configured subvolumes (@, @home, @snapshots, @var_log) + zstd compression
#   - unified kernel image (UKI) built by mkinitcpio, booted via Limine
#   - plymouth "bgrt" theme baked into the UKI, cmdline: "quiet splash"
#   - amd-ucode / intel-ucode auto-detected
#   - snapper, integrated with Limine boot entries via limine-snapper-sync (like Omarchy's setup)
#   - zram via zram-generator (zstd)
#   - NetworkManager + iwd backend, live network profiles copied to the new install
#   - sudo NOPASSWD for wheel, admin user in wheel/input/video/scanner
#   - mDNS (avahi) + printing (cups)
#   - reflector-optimized mirrorlist
#   - chaotic-aur + yay, multilib, Color/ILoveCandy/ParallelDownloads=5
#
# Run this as root from the archiso live ISO with a working network connection.

set -euo pipefail
trap 'echo -e "\n[!] Failed on line $LINENO. Nothing after that point was applied." >&2' ERR

# --------------------------------------------------------------------------
# 0. Sanity checks + gum bootstrap
# --------------------------------------------------------------------------

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root (it is meant to be run from the archiso live environment)." >&2
    exit 1
fi

if [[ ! -d /sys/firmware/efi/efivars ]]; then
    echo "This script only supports UEFI installs (Limine is configured here via efi_chainload)." >&2
    exit 1
fi

if ! command -v pacstrap &>/dev/null; then
    echo "pacstrap not found -- this script must be run from the archiso live environment." >&2
    exit 1
fi

if ! command -v gum &>/dev/null; then
    echo "[*] Installing gum..."
    pacman -Sy --noconfirm --needed gum
fi

info()    { gum style --foreground 212 "$*"; }
warn()    { gum style --foreground 214 "$*"; }
section() { gum style --border normal --margin "1 0" --padding "0 1" --border-foreground 212 "$*"; }

# --------------------------------------------------------------------------
# 1. Gather input
# --------------------------------------------------------------------------

section "Arch Linux Install"

HOSTNAME=""
while [[ -z "$HOSTNAME" ]]; do
    HOSTNAME=$(gum input --placeholder "e.g. archbox" --prompt "Hostname: ")
done

USERNAME=""
while [[ -z "$USERNAME" ]]; do
    USERNAME=$(gum input --placeholder "e.g. jdoe" --prompt "Admin username: ")
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
DISK=$(awk '{print $1}' <<<"$DRIVE_CHOICE")

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

# Create 4 subvolumes (mirrors the layout used by Omarchy's quattro setup):
#   @          -> /
#   @home      -> /home
#   @snapshots -> /.snapshots
#   @var_log   -> /var/log
mount "$ROOT_PART" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@var_log
umount /mnt

MOUNT_OPTS="noatime,compress=zstd,space_cache=v2,discard=async"

mount -o "${MOUNT_OPTS},subvol=@" "$ROOT_PART" /mnt
mkdir -p /mnt/{home,.snapshots,var/log,boot}
mount -o "${MOUNT_OPTS},subvol=@home"      "$ROOT_PART" /mnt/home
mount -o "${MOUNT_OPTS},subvol=@snapshots" "$ROOT_PART" /mnt/.snapshots
mount -o "${MOUNT_OPTS},subvol=@var_log"   "$ROOT_PART" /mnt/var/log
mount "$ESP_PART" /mnt/boot

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
    reflector                 # mirrorlist optimization
    zram-generator              # zram
    limine efibootmgr             # bootloader
    sudo
    snapper snap-pac                # snapshots
    dosfstools mtools                  # ESP/FAT tooling
)

pacstrap -K /mnt "${PACKAGES[@]}"

# --------------------------------------------------------------------------
# 5. fstab
# --------------------------------------------------------------------------

genfstab -U /mnt >> /mnt/etc/fstab
mkdir -p /mnt/mnt/NAS
echo "192.168.0.10:/mnt/md1 /mnt/NAS nfs defaults,nofail 0 0" >> /mnt/etc/fstab

# --------------------------------------------------------------------------
# 6. Copy live network configuration for first boot
# --------------------------------------------------------------------------

mkdir -p /mnt/var/lib/iwd
cp -a /var/lib/iwd/. /mnt/var/lib/iwd/ 2>/dev/null || true

mkdir -p /mnt/etc/NetworkManager/system-connections
cp -a /etc/NetworkManager/system-connections/. /mnt/etc/NetworkManager/system-connections/ 2>/dev/null || true
chmod 600 /mnt/etc/NetworkManager/system-connections/* 2>/dev/null || true

# --------------------------------------------------------------------------
# 7. Write variables + chroot configuration script
# --------------------------------------------------------------------------

cat > /mnt/root/chroot-vars.sh <<EOF
HOSTNAME=$(printf '%q' "$HOSTNAME")
USERNAME=$(printf '%q' "$USERNAME")
USERPASS=$(printf '%q' "$PASSWORD")
UCODE_PKG=$(printf '%q' "$UCODE_PKG")
TZ_REGION=$(printf '%q' "$DETECTED_TZ")
ROOT_UUID=$(printf '%q' "$ROOT_UUID")
DISK=$(printf '%q' "$DISK")
EOF
chmod 600 /mnt/root/chroot-vars.sh

cat > /mnt/root/chroot-setup.sh <<'CHSETUP'
#!/bin/bash
set -euo pipefail
source /root/chroot-vars.sh

echo "[*] Timezone + clock"
ln -sf "/usr/share/zoneinfo/$TZ_REGION" /etc/localtime
hwclock --systohc
timedatectl set-ntp true

echo "[*] Locale"
sed -i 's/^#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

echo "[*] Hostname"
echo "$HOSTNAME" > /etc/hostname
cat > /etc/hosts <<HOSTS
127.0.0.1   localhost
::1         localhost
127.0.1.1   $HOSTNAME.localdomain $HOSTNAME
HOSTS

echo "[*] Root + admin user"
echo "root:$USERPASS" | chpasswd

getent group scanner >/dev/null || groupadd scanner
useradd -m -G wheel,input,video,scanner -s /bin/bash "$USERNAME"
echo "$USERNAME:$USERPASS" | chpasswd

mkdir -p /etc/sudoers.d
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel
chmod 440 /etc/sudoers.d/wheel
visudo -c

echo "[*] zram"
cat > /etc/systemd/zram-generator.conf <<ZRAM
[zram0]
zram-size = min(ram / 2, 8192)
compression-algorithm = zstd
ZRAM

echo "[*] NetworkManager / iwd"
mkdir -p /etc/NetworkManager/conf.d
cat > /etc/NetworkManager/conf.d/wifi_backend.conf <<NMCONF
[device]
wifi.backend=iwd
NMCONF
systemctl enable NetworkManager.service

echo "[*] mDNS"
sed -i 's/^hosts:.*/hosts: mymachines mdns_minimal [NOTFOUND=return] resolve [!UNAVAIL=return] files myhostname dns/' /etc/nsswitch.conf
systemctl enable avahi-daemon.service

echo "[*] Printing"
systemctl enable cups.socket

echo "[*] mkinitcpio -> Unified Kernel Image"
sed -i 's/^HOOKS=.*/HOOKS=(base systemd autodetect microcode modconf kms keyboard sd-vconsole block sd-plymouth filesystems fsck)/' /etc/mkinitcpio.conf

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
rm -f /boot/vmlinuz-linux /boot/initramfs-linux*.img

echo "[*] Limine bootloader"
mkdir -p /boot/EFI/BOOT /boot/EFI/Limine
cp /usr/share/limine/BOOTX64.EFI /boot/EFI/BOOT/BOOTX64.EFI
cp /usr/share/limine/BOOTX64.EFI /boot/EFI/Limine/BOOTX64.EFI
efibootmgr --create --disk "$DISK" --part 1 --label "Limine" --loader '\EFI\Limine\BOOTX64.EFI' --unicode || true

cat > /boot/limine.conf <<LIMCONF
timeout: 5

/Arch Linux
    protocol: efi_chainload
    image_path: boot():/EFI/Linux/arch-linux.efi

/Arch Linux (fallback)
    protocol: efi_chainload
    image_path: boot():/EFI/Linux/arch-linux-fallback.efi
LIMCONF

mkdir -p /etc/pacman.d/hooks
cat > /etc/pacman.d/hooks/limine-update.hook <<HOOK
[Trigger]
Operation = Upgrade
Type = Package
Target = limine

[Action]
Description = Updating limine EFI binaries
When = PostTransaction
Exec = /bin/sh -c 'cp /usr/share/limine/BOOTX64.EFI /boot/EFI/BOOT/BOOTX64.EFI; cp /usr/share/limine/BOOTX64.EFI /boot/EFI/Limine/BOOTX64.EFI'
HOOK

echo "[*] Snapper (pre-created @snapshots subvolume, per Arch wiki procedure)"
umount /.snapshots || true
rm -rf /.snapshots
snapper --no-dbus -c root create-config /
btrfs subvolume delete /.snapshots
mkdir /.snapshots
mount -a
chmod 750 /.snapshots
sed -i 's/^TIMELINE_CREATE=.*/TIMELINE_CREATE="yes"/'   /etc/snapper/configs/root
sed -i 's/^TIMELINE_CLEANUP=.*/TIMELINE_CLEANUP="yes"/' /etc/snapper/configs/root
systemctl enable snapper-timeline.timer snapper-cleanup.timer

echo "[*] Reflector"
mkdir -p /etc/xdg/reflector
cat > /etc/xdg/reflector/reflector.conf <<REFCONF
--save /etc/pacman.d/mirrorlist
--protocol https
--latest 20
--sort rate
REFCONF
systemctl enable reflector.service
reflector --protocol https --latest 20 --sort rate --save /etc/pacman.d/mirrorlist || true

echo "[*] pacman.conf tweaks (Color, ILoveCandy, ParallelDownloads, multilib)"
sed -i 's/^#Color/Color/' /etc/pacman.conf
grep -q '^ILoveCandy' /etc/pacman.conf || sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
sed -i 's/^#\?ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf
sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf

echo "[*] Chaotic-AUR"
pacman-key --recv-key 3056513887B78AEB --keyserver keyserver.ubuntu.com
pacman-key --lsign-key 3056513887B78AEB
pacman -U --noconfirm \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst' \
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
grep -q 'chaotic-aur' /etc/pacman.conf || cat >> /etc/pacman.conf <<CHAOTIC

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
CHAOTIC

pacman -Sy --noconfirm
pacman -S --noconfirm --needed yay limine-snapper-sync
systemctl enable limine-snapper-sync.service || true

echo "[*] Chroot configuration complete."
CHSETUP
chmod 700 /mnt/root/chroot-setup.sh

# --------------------------------------------------------------------------
# 8. Run the chroot script
# --------------------------------------------------------------------------

section "Configuring installed system (chroot)"
arch-chroot /mnt /bin/bash /root/chroot-setup.sh

rm -f /mnt/root/chroot-setup.sh /mnt/root/chroot-vars.sh

# --------------------------------------------------------------------------
# 9. Done
# --------------------------------------------------------------------------

section "Install complete"
info "Unmounting..."
umount -R /mnt

cat <<DONE

Arch Linux has been installed to ${DISK}.

Notes:
  - Bootloader: Limine, chainloading UKIs from /boot/EFI/Linux (ESP mounted at /boot)
  - btrfs subvolumes: @, @home, @snapshots, @var_log (compress=zstd)
  - Snapper is configured on the 'root' config; limine-snapper-sync is enabled
    to add snapshot boot entries -- check 'man limine-snapper-sync' / its repo
    for any tuning you want (submenu naming, snapshot count, etc.).
  - Wi-Fi/network profiles from the live session were copied over for first boot.
  - Admin user '${USERNAME}' has passwordless sudo via /etc/sudoers.d/wheel.

You can now 'reboot'.
DONE
