#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Yazi"

packages=(
  yazi
  ffmpeg
  mediainfo
  poppler
  resvg
  imagemagick
  rich-cli
  ouch
  7zip
  wl-clipboard
)

yay -S --needed --noconfirm "${packages[@]}"
