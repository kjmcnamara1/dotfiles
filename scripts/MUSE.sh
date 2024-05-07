#!/usr/bin/env bash

# Partition Disk
fdisk /dev/nvme0n1 <<EOF
g
n
1

+512M
t
1
n
2

+20G
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
genfstab -U /mnt >>/mnt/etc/fstab
arch-chroot /mnt

# Time
ln -sf "/usr/share/zoneinfo/$(curl https://ipapi.co/timezone)" /etc/localtime
hwclock --systohc
systemctl enable systemd-timesyncd.service

# Locale
sed -i '/en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen # Uncomment line
locale-gen
echo "LANG=en_US.UTF-8" >/etc/locale.conf
echo "KEYMAP=us" >/etc/vconsole.conf

# Hostname
echo "MUSE" >/etc/hostname

# Initramfs
mkinitcpio -P

# Root Password
passwd

# Add User
useradd -m -G wheel -s /usr/bin/fish kevin
passwd kevin
echo "kevin ALL=(ALL) ALL" >/etc/sudoers.d/00_kevin
chmod 0440 /etc/sudoers.d/00_kevin

# Boot Loader
efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'initrd=\amd-ucode.img initrd=\initramfs-linux.img root=/dev/nvme0n1p2 rootfstype=ext4 rw quiet splash'

# Network Manager
systemctl enable NetworkManager.service

# Desktop Environment
pacman -S --noconfirm plasma egl-wayland kde-applications kvantum dosfstools # ark konsole dolphin
# Additional Packages
pacman -S --noconfirm openssh nodejs npm xclip unzip zstd
# Terminal tools
pacman -S --noconfirm eza tmux fzf fd ripgrep zoxide starship ttf-jetbrains-mono-nerd
# Python tools
pacman -S --noconfirm python-poetry pyenv
# Graphical apps
pacman -S --noconfirm wezterm freecad inkscape gimp obsidian
# Candy apps
pacman -S --noconfirm xcape # kbd fuse2

systemctl enable sddm.service

# Switch users
su kevin

# Yay
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si && yay --version
# AUR apps
yay -S --noconfirm brave-bin neovim-nightly-bin visual-studio-code-bin megasync-bin dolphin-megasync-bin carapace-bin
# Proton VPN
yay -S --noconfirm protonvpn network-manager-applet
# AUR extras
# yay -S teamviewer youtube onedrive-abraunegg logiops displaylink logkeys-git

# Dotfiles
# mkdir ~/Code && cd ~/Code && git clone --recurse-submodules git@github.com:kjmcnamara1/dotfiles && cd dotfiles
# ./sync.py
