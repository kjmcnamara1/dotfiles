#!/usr/bin/env bash

source gum-helper.sh

tweak_pacman_conf() {
  sed -i 's/^#Color/Color/' /etc/pacman.conf
  grep -q '^ILoveCandy' /etc/pacman.conf || sed -i '/^Color/a ILoveCandy' /etc/pacman.conf
  sed -i 's/^#\?ParallelDownloads.*/ParallelDownloads = 5/' /etc/pacman.conf
  sed -i '/^#\[multilib\]/,/^#Include/ s/^#//' /etc/pacman.conf
}

setup_chaotic_aur() {
  local key=3056513887B78AEB ks
  local urls=(
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-keyring.pkg.tar.zst'
    'https://cdn-mirror.chaotic.cx/chaotic-aur/chaotic-mirrorlist.pkg.tar.zst'
  )
  for ks in keyserver.ubuntu.com keys.openpgp.org pgp.mit.edu; do
    sudo pacman-key --recv-key "$key" --keyserver "$ks" && break
  done
  sudo pacman-key --list-keys "$key" > /dev/null 2>&1 || return 1
  sudo pacman-key --lsign-key "$key" || return 1
  sudo pacman -U --noconfirm "${urls[@]}" || sudo pacman -U --noconfirm "${urls[@]}" || return 1
  sudo grep -q '^\[chaotic-aur\]' /etc/pacman.conf || cat << CHAOTIC | sudo tee -a /etc/pacman.conf

[chaotic-aur]
Include = /etc/pacman.d/chaotic-mirrorlist
CHAOTIC

  pacman -Sy --noconfirm || return 1
}

section "Configure Package Manager"

info "Pacman.conf tweaks..."
tweak_pacman_conf

info "Setting up Chaotic-AUR..."
setup_chaotic_aur

info "Installing yay..."
pacman -S --noconfirm --needed yay
