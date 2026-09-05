#!/usr/bin/env bash

# This script is sourced after the target system is mounted at archmount. It
# configures the Btrfs root, Plymouth's firmware-logo theme, and UKIs that
# systemd-boot discovers directly from the ESP.
: "${archmount:?archmount must be set before sourcing configure-initramfs.sh}"

# btrfs-progs supplies the mkinitcpio btrfs hook. Plymouth includes the bgrt
# theme, which reuses the UEFI firmware's boot graphic when one is available.
arch-chroot "$archmount" pacman -S --needed --noconfirm btrfs-progs plymouth

# A Btrfs root on a single device can boot with the filesystems hook alone, but
# the btrfs hook also handles device scanning and makes this layout work if the
# filesystem is later converted to a multi-device volume.
sed -i '/^HOOKS=/!b; /plymouth/!s/\(base udev\)/\1 plymouth/' \
  "$archmount/etc/mkinitcpio.conf"
sed -i '/^HOOKS=/!b; / btrfs\|^HOOKS=.*btrfs/!s/\(filesystems\)/\1 btrfs/' \
  "$archmount/etc/mkinitcpio.conf"

# Embed the command line in every UKI. There are deliberately no loader-entry
# options: an embedded UKI command line is authoritative when Secure Boot is
# enabled.
install -d "$archmount/etc/kernel" "$archmount/boot/EFI/Linux" \
  "$archmount/boot/loader"
printf 'quiet splash\n' > "$archmount/etc/kernel/cmdline"

# Use mkinitcpio's native UKI preset format. The ESP is mounted at /boot, so
# systemd-boot will auto-discover these images in /boot/EFI/Linux.
cat > "$archmount/etc/mkinitcpio.d/linux.preset" << 'EOF'
# mkinitcpio preset for systemd-boot-discoverable unified kernel images.
ALL_config="/etc/mkinitcpio.conf"
ALL_kver="/boot/vmlinuz-linux"

PRESETS=('default' 'fallback')

default_uki="/boot/EFI/Linux/arch-linux.efi"
fallback_uki="/boot/EFI/Linux/arch-linux-fallback.efi"
fallback_options="-S autodetect"
EOF

cat > "$archmount/boot/loader/loader.conf" << 'EOF'
default @saved
timeout 0
console-mode max
editor no
EOF

# Install the systemd-boot files on the mounted ESP. --root makes this safe to
# run from the installer even though the new system is not the running root.
bootctl --root="$archmount" install
arch-chroot "$archmount" plymouth-set-default-theme bgrt
arch-chroot "$archmount" mkinitcpio -P
