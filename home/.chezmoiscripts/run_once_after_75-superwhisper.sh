#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Superwhisper"

# Retire voxtype if a previous apply installed it
if systemctl --user list-unit-files voxtype.service &>/dev/null; then
  systemctl --user disable --now voxtype.service 2>/dev/null || true
fi
pacman -Qq voxtype-bin &>/dev/null && yay -Rns --noconfirm voxtype-bin

# Installs the binary and superwhisper.service (user unit)
if ! command -v superwhisper &>/dev/null; then
  curl -fsSL https://tux.superwhisper.com/install.sh | sh
fi

systemctl --user daemon-reload
systemctl --user enable --now superwhisper.service ||
  warn "Start failed; run 'superwhisper doctor'"
