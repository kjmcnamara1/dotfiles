#!/usr/bin/env bash

# This script is sourced by install.sh after the disk layout is mounted. It
# uses the caller's archmount variable so packages are installed into the new
# system rather than the live ISO environment.
: "${archmount:?archmount must be set before sourcing install-essential-packages.sh}"

# Bootstrap the base system and tools required for package management,
# documentation, networking/downloads, and applying this dotfiles repository.
pacstrap -K "$archmount" \
  base \
  base-devel \
  pacman-contrib \
  linux \
  linux-firmware \
  btrfs-progs \
  man-db \
  man-pages \
  git \
  sudo \
  wget \
  curl \
  chezmoi
