#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Shell"

packages=(
  fish
  ttf-jetbrains-mono-nerd
  ttf-nerd-fonts-symbols
  noto-fonts
  noto-fonts-emoji
  figlet
  figlet-fonts-extra
  bat
  eza
  jq
  starship
  fd
  ripgrep
  fzf
  television
  zoxide
  pv
  tldr
  fastfetch
  udiskie

  herdr-bin
  cliamp-bin
  bonsai

  gum
  silicon
  vhs
  asciinema
  asciinema-edit
  asciinema-agg

  bottom
  rocm-smi-lib

  yt-dlp

  mise
  pixi
)

yay -S --needed --noconfirm "${packages[@]}"

systemctl --user enable --now udiskie

sudo chsh -s "$(which fish)" "$USER"
