#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Dank Material Shell"

packages=(
  dms-shell
  quickshell
  dsearch
  matugen
  niri
  qt6-multimedia
  cava
  greetd-dms-greeter-bin
  dsearch-bin
  power-profiles-daemon
  cups-pk-helper
  kimageformats
  wl-clipboard
  uwsm

  nautilus
  sshfs
  gvfs
  gvfs-smb
  gvfs-nfs
  gvfs-google
  gvfs-onedrive

  gnome-disk-utility
  adw-gtk-theme
  papirus-icon-theme
  nordzy-cursors
)

yay -S --needed --noconfirm "${packages[@]}"

systemctl --user enable --now dms
systemctl --user add-wants niri.service dms

dms-greeter install

dsearch index generate
