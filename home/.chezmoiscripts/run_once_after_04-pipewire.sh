#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Pipewire"

packages=(
  pipewire
  wireplumber
  pipewire-pulse
  pipewire-alsa
)

yay -S --needed --noconfirm "${packages[@]}"

systemctl --user enable --now pipewire
systemctl --user enable --now wireplumber
systemctl --user enable --now pipewire-pulse
