#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "greetd PAM (gnome-keyring unlock)"

info "Installing /etc/pam.d/greetd with pam_gnome_keyring"
sudo install -m644 "${CHEZMOI_SOURCE_DIR}/../arch/etc/pam.d/greetd" /etc/pam.d/greetd
