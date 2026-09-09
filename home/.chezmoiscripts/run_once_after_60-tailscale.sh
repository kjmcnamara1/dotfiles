#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Tailscale"

packages=(
  tailscale
)

yay -S --needed --noconfirm "${packages[@]}"

sudo systemctl enable --now tailscaled
sudo tailscale up
