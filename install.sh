#!/usr/bin/env bash
set -euo pipefail

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root." >&2
  exit 1
fi

gum style --foreground 212 --border double --margin "1" --padding "1" \
  "Arch Linux Btrfs + Snapper + systemd-boot Snapshots Installer"

# --- User Prompts via Gum ---
HOSTNAME=$(gum input --placeholder "Hostname" \
  --value "archlinux" --header "Enter HostNAME:")
ROOT_PASS=$(gum input --password \
  --placeholder "Root Password" --header "Enter ROOT password:")
ADMIN_USER=$(gum input --placeholder "Admin Username" \
  --value "kjm" --header "Enter ADMIN username:")
ADMIN_PASS=$(gum input --password \
  --placeholder "Admin Password" --header "Enter ADMIN password:")

# Drive selection
DRIVES=$(lsblk -dno NAME,SIZE,MODEL | grep -v "loop" | grep -v "sr")
SELECTED_DRIVE_LINE=$(echo "$DRIVES" \
                                     | gum choose --header "Select target drive to ERASE and install to:")
TARGET_DRIVE="/dev/$(echo "$SELECTED_DRIVE_LINE" | awk '{print $1}')"

gum confirm "WARNING: ALL DATA ON $TARGET_DRIVE WILL BE ERASED! Proceed?"

 # --- Ensure Drive & Mount Targets are Unmounted ---
echo "Ensuring target drive and mount points are clean..."
if mountpoint -q /mnt; then
  umount -R /mnt || true
fi

# Unmount any existing partitions on target drive
for part in $(lsblk -lno NAME "$TARGET_DRIVE" | tail -n +2); do
  if mountpoint -q "/dev/$part"; then
    umount -l "/dev/$part" 2> /dev/null || true
  fi
done

# Wipe active swap on target drive if present
swapoff -a 2> /dev/null || true                                                                        || exit 1

# --- Timezone Detection ---
echo "Detecting timezone..."
TIMEZONE=$(curl -fsS --max-time 5 https://ipapi.co/timezone || true)
if [[ -z "$TIMEZONE" ]]; then
  TIMEZONE="America/New_York"
  echo "Fallback timezone used: $TIMEZONE"
else
  echo "Detected timezone: $TIMEZONE"
fi

# --- Partitioning & Btrfs Layout ---
echo "Partitioning $TARGET_DRIVE..."
sgdisk -Z "$TARGET_DRIVE"
sgdisk -n 1:0:+1G -t 1:ef00 -c 1:"ESP" "$TARGET_DRIVE"
sgdisk -n 2:0:0   -t 2:8300 -c 2:"ARCH" "$TARGET_DRIVE"

if [[ "$TARGET_DRIVE" =~ "nvme" ]] || [[ "$TARGET_DRIVE" =~ "mmcblk" ]]; then
  BOOT_PART="${TARGET_DRIVE}p1"
  ROOT_PART="${TARGET_DRIVE}p2"
else
  BOOT_PART="${TARGET_DRIVE}1"
  ROOT_PART="${TARGET_DRIVE}2"
fi

mkfs.vfat -F 32 "$BOOT_PART"
mkfs.btrfs -f "$ROOT_PART"

# Btrfs Subvolume Creation
mount "$ROOT_PART" /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@var
btrfs subvolume create /mnt/@snapshots
btrfs subvolume create /mnt/@games
umount /mnt

# Mount Subvolumes
MOUNT_OPTS="noatime,compress=zstd,space_cache=v2"
mount -o "$MOUNT_OPTS,subvol=@" "$ROOT_PART" /mnt
mkdir -p /mnt/{boot,home,var,.snapshots,games,mnt/NAS}
mount -o "$MOUNT_OPTS,subvol=@home" "$ROOT_PART" /mnt/home
mount -o "$MOUNT_OPTS,subvol=@var" "$ROOT_PART" /mnt/var
mount -o "$MOUNT_OPTS,subvol=@snapshots" "$ROOT_PART" /mnt/.snapshots
mount -o "$MOUNT_OPTS,subvol=@games" "$ROOT_PART" /mnt/games
mount "$BOOT_PART" /mnt/boot

# --- Pacstrap ---
echo "Installing base packages..."
pacstrap /mnt base base-devel pacman-contrib linux linux-firmware \
  btrfs-progs plymouth man-db man-pages git wget curl chezmoi \
  networkmanager iwd nfs-utils sudo systemd-ukify \
  snapper snap-pac

# Generate fstab
genfstab -U /mnt >> /mnt/etc/fstab
echo "\n# NAS\n192.168.0.10:/mnt/md1 /mnt/NAS nfs defaults,nofail 0 0\n" >> /mnt/etc/fstab

# --- Chroot Configuration ---
arch-chroot /mnt /bin/bash -e << EOF
# Timezone & Hardware Clock
ln -sf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
hwclock --systohc
systemctl enable systemd-timesyncd

# Localization
echo "en_US.UTF-8 UTF-8" > /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" > /etc/locale.conf
echo "KEYMAP=us" > /etc/vconsole.conf

# Hostname
echo "$HOSTNAME" > /etc/hostname

# Users & Passwords
echo "root:$ROOT_PASS" | chpasswd
useradd -m -G wheel,input,video,scanner -s /bin/bash "$ADMIN_USER"
echo "$ADMIN_USER:$ADMIN_PASS" | chpasswd

# Sudo privileges
echo "%wheel ALL=(ALL:ALL) NOPASSWD: ALL" > /etc/sudoers.d/wheel

# Network Configuration
systemctl enable NetworkManager
mkdir -p /etc/NetworkManager/conf.d
cat <<NMMCONFIG > /etc/NetworkManager/conf.d/iwd.conf
[device]
wifi.backend=iwd
NMMCONFIG

# Plymouth Configuration
sed -i 's/^HOOKS=.*/HOOKS=(base systemd autodetect modconf kms block btrfs filesystems keyboard fsck plymouth)/' /etc/mkinitcpio.conf
plymouth-set-default-theme -R bgrt

# systemd-boot & UKI Setup
bootctl install

mkdir -p /etc/cmdline.d
echo "root=UUID=\$(blkid -s UUID -o value $ROOT_PART) rootflags=subvol=@ rw quiet splash" > /etc/cmdline.d/root.conf

cat <<UKICONF > /etc/mkinitcpio.d/linux.preset
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/vmlinuz-linux"

PRESETS=('default')
default_image="/boot/initramfs-linux.img"
default_uki="/boot/EFI/Linux/arch-linux.efi"
UKICONF

mkinitcpio -P

# --- Snapper Configuration ---
umount /.snapshots
rm -r /.snapshots

snapper --no-dbus -c root create-config /
rm -rf /.snapshots
mkdir /.snapshots
mount -o "$MOUNT_OPTS,subvol=@snapshots" "$ROOT_PART" /.snapshots

chown -R root:wheel /.snapshots
chmod 750 /.snapshots

sed -i 's/^ALLOW_GROUPS=.*/ALLOW_GROUPS="wheel"/' /etc/snapper/configs/root
sed -i 's/^NUMBER_LIMIT=.*/NUMBER_LIMIT="10"/' /etc/snapper/configs/root
sed -i 's/^NUMBER_LIMIT_IMPORTANT=.*/NUMBER_LIMIT_IMPORTANT="5"/' /etc/snapper/configs/root
sed -i 's/^TIMELINE_LIMIT_HOURLY=.*/TIMELINE_LIMIT_HOURLY="5"/' /etc/snapper/configs/root
sed -i 's/^TIMELINE_LIMIT_DAILY=.*/TIMELINE_LIMIT_DAILY="7"/' /etc/snapper/configs/root
sed -i 's/^TIMELINE_LIMIT_WEEKLY=.*/TIMELINE_LIMIT_WEEKLY="2"/' /etc/snapper/configs/root
sed -i 's/^TIMELINE_LIMIT_MONTHLY=.*/TIMELINE_LIMIT_MONTHLY="0"/' /etc/snapper/configs/root
sed -i 's/^TIMELINE_LIMIT_YEARLY=.*/TIMELINE_LIMIT_YEARLY="0"/' /etc/snapper/configs/root

systemctl enable snapper-timeline.timer
systemctl enable snapper-cleanup.timer

# --- Build snapper-in-boot from AUR for systemd-boot Integration ---
sudo -u "$ADMIN_USER" bash -c "
  cd /tmp
  git clone https://aur.archlinux.org/snapper-in-boot.git
  cd snapper-in-boot
  makepkg -si --noconfirm
"

# Enable automatic boot loader entry generation on snapshot creation
systemctl enable snapper-in-boot.path
EOF

# --- Copy NetworkManager Connections ---
echo "Copying active NetworkManager connections..."
if [ -d /etc/NetworkManager/system-connections/ ]; then
  cp -a /etc/NetworkManager/system-connections/* \
    /mnt/etc/NetworkManager/system-connections/ 2> /dev/null || true
fi

# Cleanup and Finish
umount -R /mnt
gum style --foreground 82 "Installation Complete! Boot entries for Snapper snapshots are ready in systemd-boot."
