#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Voxtype"

packages=(
  voxtype-bin
  wtype
  wl-clipboard
  libnotify
)

yay -S --needed --noconfirm "${packages[@]}"

# Hotkey is read via evdev
groups | grep -qw input || sudo usermod -aG input "$USER"

voxtype setup --download || warn "Model download failed; run 'voxtype setup --download'"

systemctl --user daemon-reload
systemctl --user enable --now voxtype.service
