#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Terminal"

packages=(
  kitty
  ghostty
  wezterm
  alacritty
)

yay -S --needed --noconfirm "${packages[@]}"
