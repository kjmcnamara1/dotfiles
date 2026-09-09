#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "GUIs"

packages=(
  brave-origin-bin
  libreoffice-fresh
  proton-pass-bin
  imv
  mpv
  mpv-mpris
  mpd
  mpd-mpris
  playerctl
  visual-studio-code-bin
  zed-preview-bin
  baobab
  evince
  localsend
)

yay -S --needed --noconfirm "${packages[@]}"
