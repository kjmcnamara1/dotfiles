#!/usr/bin/env bash

# Enable Network Time Protocol
timedatectl set-ntp true

# SSH
ssh-keygen
echo "SSH public key:"
cat ~/.ssh/id_ed25519.pub
echo
read -p "Copy public SSH key and create new key at https://github.com/settings/ssh/new. Press enter when done."

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519
ssh -T git@github.com

# Yay
git clone https://aur.archlinux.org/yay.git /tmp/yay && cd /tmp/yay && makepkg -si && yay --version
# AUR apps
yay -S --noconfirm brave-bin neovim-nightly-bin visual-studio-code-bin megasync-bin dolphin-megasync-bin carapace-bin kwin-bismuth
# Proton apps
yay -S --noconfirm proton-vpn-gtk-app network-manager-applet protonmail-desktop proton-pass-bin
# AUR extras
# yay -S teamviewer youtube onedrive-abraunegg logiops displaylink logkeys-git

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.cache/tmux/plugins/tpm

# Dotfiles
mkdir ~/Code && cd ~/Code && git clone --recurse-submodules git@github.com:kjmcnamara1/dotfiles && cd dotfiles && chmod +x sync.py && ./sync.py

# Python
pyenv install 3.12
pyenv global 3.12
