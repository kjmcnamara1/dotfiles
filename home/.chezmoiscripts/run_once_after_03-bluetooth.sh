#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Bluetooth"

packages=(
  bluez
  bluez-utils
  bluetui
)

yay -S --needed --noconfirm "${packages[@]}"

sudo systemctl enable --now bluetooth.service
