#!/usr/bin/env bash

# Read configuration values from user
echo
read -s -P "Root Password: " rootpwd
echo
read -P "Admin Username: " username
echo
read -s -P "Admin User Password: " userpwd
echo

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
# arch-chroot /mnt

# Time
arch-chroot /mnt ln -sf "/usr/share/zoneinfo/$(curl https://ipapi.co/timezone)" /etc/localtime
arch-chroot /mnt hwclock --systohc
arch-chroot /mnt systemctl enable systemd-timesyncd.service

# Locale
arch-chroot /mnt sed -i '/en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen # Uncomment line
arch-chroot /mnt locale-gen
arch-chroot /mnt echo "LANG=en_US.UTF-8" > /etc/locale.conf
arch-chroot /mnt echo "KEYMAP=us" > /etc/vconsole.conf

# Hostname
arch-chroot /mnt echo "MUSE" > /etc/hostname

# Initramfs
arch-chroot /mnt mkinitcpio -P

# Root Password
echo "root:$rootpwd" | arch-chroot /mnt chpasswd

# Add User
arch-chroot /mnt useradd -m -G wheel -s /usr/bin/fish $username
echo "$username:$userpwd" | arch-chroot /mnt chpasswd
arch-chroot /mnt echo "$username ALL=(ALL) ALL" > "/etc/sudoers.d/00_$username"
arch-chroot /mnt chmod 0440 "/etc/sudoers.d/00_$username"

# Boot Loader
arch-chroot /mnt efibootmgr --create --disk /dev/nvme0n1 --part 1 --label "Arch Linux" --loader /vmlinuz-linux --unicode 'initrd=\amd-ucode.img initrd=\initramfs-linux.img root=/dev/nvme0n1p2 rootfstype=ext4 rw quiet splash'

# Network Manager
arch-chroot /mnt systemctl enable NetworkManager.service

# Full KDE and apps
# pacman -S --noconfirm plasma-meta kde-applications-meta

# Desktop Environment
arch-chroot /mnt pacman -S --noconfirm plasma-desktop egl-wayland
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

arch-chroot /mnt systemctl enable sddm.service

# Switch users
# su $username

# Yay
arch-chroot -u $username /mnt git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si && yay --version
# AUR apps
arch-chroot -u $username /mnt yay -S --noconfirm brave-bin neovim-nightly-bin visual-studio-code-bin megasync-bin dolphin-megasync-bin carapace-bin kwin-bismuth
# Proton VPN
arch-chroot -u $username /mnt yay -S --noconfirm protonvpn network-manager-applet
# AUR extras
# arch-chroot -u $username /mnt yay -S teamviewer youtube onedrive-abraunegg logiops displaylink logkeys-git

# Install Tmux Plugin Manager
arch-chroot -u $username /mnt git clone https://github.com/tmux-plugins/tpm ~/.cache/tmux/plugins/tpm

# Python
arch-chroot -u $username /mnt pyenv install 3.12
arch-chroot -u $username /mnt pyenv global 3.12

# SSH
arch-chroot -u $username /mnt ssh-keygen
echo "SSH public key:"
cat "/mnt/home/$username/.ssh/id_ed25519.pub"
echo
read -P "Copy public SSH key and create new key at https://github.com/settings/ssh/new. Press enter when done."
echo
arch-chroot -u $username /mnt eval "$(ssh-agent -s)"
arch-chroot -u $username /mnt ssh-add ~/.ssh/id_ed25519
arch-chroot -u $username /mnt ssh -T git@github.com

# Dotfiles
arch-chroot -u $username /mnt mkdir ~/Code && cd ~/Code && git clone --recurse-submodules git@github.com:kjmcnamara1/dotfiles && cd dotfiles && chmod +x sync.py && ./sync.py
