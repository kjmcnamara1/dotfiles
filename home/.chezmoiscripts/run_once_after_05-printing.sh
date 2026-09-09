#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Printing"

packages=(
  cups
  cups-filters
  cups-pdf
  cups-pk-helper
  libcups
  avahi
  nss-mdns
  system-config-printer

  sane
  libksane
  sane-airscan
  simple-scan
)

yay -S --needed --noconfirm "${packages[@]}"

systemctl enable --now cups
systemctl enable --now avahi-daemon
