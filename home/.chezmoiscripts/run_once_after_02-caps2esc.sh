#!/usr/bin/env bash

source "${CHEZMOI_SOURCE_DIR}/../scripts/gum-helper.sh"

section "Caps2Esc"

packages=(
  interception-caps2esc
)

yay -S --needed --noconfirm "${packages[@]}"

cat << CAPS2ESC | sudo tee /etc/interception/udevmon.d/caps2esc.yaml
# /etc/interception/udevmon.d/caps2esc.yaml
- JOB: "intercept -g $DEVNODE | caps2esc -m 1 | uinput -d $DEVNODE"
  DEVICE:
    NAME: "^((?!(Glove80|Corne)).)*$"
    EVENTS:
      EV_KEY: [[KEY_CAPSLOCK, KEY_ESC]]
CAPS2ESC

systemctl enable --now udevmon
