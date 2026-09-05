#!/usr/bin/env bash

# print each command before it is executed, expanding variables
set -x

read -rp "Hostname: " hostname
read -rps "Root Password: " root_password
read -rp "Admin Username: " username
read -rps "Admin User Password: " password

dotfiles="/tmp/dotfiles"
config="$dotfiles/arch/$hostname.json"
users="$dotfiles/arch/users.json"
archmount="/mnt"

# [x] Update package databse and install dependencies
pacman -Sy
pacman -S --needed --noconfirm git jq

# [x] Clean clone of machine specific dotfiles branch
# rm -rf "$dotfiles"
# git clone --branch "$host" https://github.com/kjmcnamara1/dotfiles "$dotfiles"

source scripts/remove-boot-entries.sh

# [x] Install arch with machine specific config, including disk layout
archinstall --config "$config" --creds "$users"
# source scripts/install-arch.sh
# partition disk
# format partitions
# mount filesystems
# install essential-packages: base base-devel pacman-contrib linux linux-firmware man-db man-pages git wget curl chezmoi
# gen fstab
# configure clock
# configure locale
# write hostname
# initramfs: mkinitcpio -P -A plymouth
# set root password
# add admin user
# create bootloader entry with systemd-boot

# -----------EVERYTHING BELOW SHOULD BE DONE WITH CHEZMOI----------

# [x] Copy interception-tools config and pacman.conf
cp -r "$dotfiles/arch/etc" "$archmount"

# [x] Init and apply dotfiles
arch-chroot "$archmount" bash -c "sudo -H -u $username chezmoi init --branch $hostname --apply kjmcnamara1"

# read -rp "Press enter to continue..."

# [x] Disable default action of power button
sed -i 's/.*HandlePowerKey=.*/HandlePowerKey=ignore/' \
  "$archmount/etc/systemd/logind.conf"
# [x] Add mDNS for printer
sed -i 's/mymachines resolve/mymachines mdns_minimal [NOTFOUND=return] resolve/' \
  "$archmount/etc/nsswitch.conf"
# [x] Add NAS mount to fstab
grep -q "192.168.0.10:/mnt/md1" "$archmount/etc/fstab" \
  || printf "\n# /mnt/NAS\n192.168.0.10:/mnt/md1 /mnt/NAS nfs defaults,nofail 0 0" >> "$archmount/etc/fstab"

# [x] Idempotently add 'quiet splash' to all boot entries
for entry in "$archmount"/boot/loader/entries/*.conf; do
  sudo sed -i '/^options / { s/ quiet//g; s/ splash//g; s/$/ quiet splash/ }' "$entry"
done
# [x] Add plymouth to mkinitcpio hooks after 'base udev'
# it will only add 'plymouth' if it is not already present
sed -i '/^HOOKS=/!b; /plymouth/!s/\(base udev\)/\1 plymouth/' \
  "$archmount/etc/mkinitcpio.conf"
# [x] Change theme and regenerate initramfs
arch-chroot "$archmount" plymouth-set-default-theme -R arch-charge-big
# [x] Write systemd-boot config (Should also change the EFI variable)
bootctl --esp-path="$archmount/boot" --boot-path="$archmount/boot" set-timeout "0"

# reboot
