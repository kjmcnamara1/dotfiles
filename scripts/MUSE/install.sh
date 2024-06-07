#!/usr/bin/env bash

# Read configuration values from user
echo
read -s -p "Root Password: " rootpwd
echo
read -p "Admin Username: " username
read -s -p "Admin User Password: " userpwd

# Partition Disk
fdisk /dev/nvme0n1 << EOF
g
n
1

+512M
t
1
n
2

+100G
n
3


t
3
42
p
w
EOF

# Format Partitions
mkfs.fat -F 32 /dev/nvme0n1p1      # EFI system partition as FAT32
mkfs.ext4 -L "OS" /dev/nvme0n1p2   # Linux filesystem partition as ext4
mkfs.ext4 -L "DATA" /dev/nvme0n1p3 # Linux home partition as ext4

# Mount Filesystem
mount /dev/nvme0n1p2 /mnt
mount --mkdir /dev/nvme0n1p1 /mnt/boot
mount --mkdir /dev/nvme0n1p3 /mnt/home

# Install Essential Packages
pacstrap -K /mnt base base-devel linux linux-firmware man-db man-pages texinfo networkmanager amd-ucode fish vim git wget curl efibootmgr

# System Configuration
genfstab -U /mnt >> /mnt/etc/fstab

# Time
arch-chroot /mnt ln -sf "/usr/share/zoneinfo/$(curl https://ipapi.co/timezone)" /etc/localtime
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt systemctl enable systemd-timesyncd.service

# Locale
sed -i '/en_US.UTF-8 UTF-8/s/^#//' /mnt/etc/locale.gen # Uncomment line
arch-chroot /mnt locale-gen
echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf
echo "KEYMAP=us" > /mnt/etc/vconsole.conf

# Hostname
echo "MUSE" > /mnt/etc/hostname

# Initramfs
arch-chroot /mnt mkinitcpio -P

# Root Password
echo "root:$rootpwd" | arch-chroot /mnt chpasswd

# Add User
arch-chroot /mnt useradd -m -G wheel -s /usr/bin/fish $username
echo "$username:$userpwd" | arch-chroot /mnt chpasswd
echo "$username ALL=(ALL) ALL" > "/mnt/etc/sudoers.d/00_$username"
chmod 0440 "/mnt/etc/sudoers.d/00_$username"

# Boot Loader
arch-chroot /mnt efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'initrd=\amd-ucode.img initrd=\initramfs-linux.img root=/dev/nvme0n1p2 rootfstype=ext4 rw quiet splash'

# Network Manager
arch-chroot /mnt systemctl enable NetworkManager.service

# Full KDE and apps
# pacman -S --noconfirm plasma-meta kde-applications-meta

# Desktop Environment
arch-chroot /mnt pacman -S --noconfirm plasma-meta egl-wayland
# Plasma Apps
arch-chroot /mnt pacman -S --noconfirm kvantum dosfstools ark konsole dolphin partitionmanager kdeconnect
# Additional Packages
arch-chroot /mnt pacman -S --noconfirm openssh nodejs npm xclip unzip zstd
# Terminal tools
arch-chroot /mnt pacman -S --noconfirm eza tmux fzf fd ripgrep zoxide starship ttf-jetbrains-mono-nerd
# Python tools
arch-chroot /mnt pacman -S --noconfirm python-poetry pyenv
# Graphical apps
arch-chroot /mnt pacman -S --noconfirm wezterm freecad inkscape gimp obsidian
# Candy apps
arch-chroot /mnt pacman -S --noconfirm xcape # kbd fuse2

# Enable display manager
arch-chroot /mnt systemctl enable sddm.service

# Reboot into OS
reboot
