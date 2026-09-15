#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Terminal"

packages=(
  git
  github-cli
  lazygit
  git-delta
  difftastic
  jujutsu
  jjui-bin
)

yay -S --needed --noconfirm "${packages[@]}"
