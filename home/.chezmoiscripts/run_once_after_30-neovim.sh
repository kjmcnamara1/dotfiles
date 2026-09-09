#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Neovim"

packages=(
  neovim
  helix
  tree-sitter-cli
  luarocks
  nodejs
  npm
  shellcheck
)

yay -S --needed --noconfirm "${packages[@]}"
