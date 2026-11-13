#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Virtual machines"

packages=(
  docker
  docker-compose
  freerdp
  openbsd-netcat
  tigervnc # vncviewer for the macOS and Linux VMs
  xwayland-satellite # xfreerdp3 is an X11 client
)

yay -S --needed --noconfirm "${packages[@]}"

sudo systemctl enable --now docker.service
sudo usermod -aG docker "$USER"
info "Log out and back in for docker group membership, then run: windows-vm install"
