#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Gaming"

packages=(
    steam
    lutris
    wine
    vulkan-radeon
    lib32-vulkan-radeon
    mangohud
    lib32-mangohud
    gamescope
    gamemode
    lib32-gamemode
    dxvk-bin
    vkd3d
    lib32-vkd3d
    protonup-qt
)

yay -S --needed --noconfirm "${packages[@]}"
