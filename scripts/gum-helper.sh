#!/usr/bin/env bash

if ! command -v gum &> /dev/null; then
    echo "[*] Installing gum..."
    pacman -Sy --noconfirm --needed gum
fi

info()    { gum style --foreground 212 "$*"; }
warn()    { gum style --foreground 214 "$*"; }
section() { gum style --border normal --margin "1 0" --padding "0 1" --border-foreground 212 "$*"; }
require() { "$@" || {
                      echo "[!] REQUIRED step failed: $*" >&2
                                                               exit 1
};                                                                        }
