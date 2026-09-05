#!/usr/bin/env bash

# This script is sourced after the base system has been installed at archmount.
# Enable the requested UTF-8 locale, generate it, and make it the default.
: "${archmount:?archmount must be set before sourcing configure-locale.sh}"

locale_gen="$archmount/etc/locale.gen"

# Uncomment the en_US.UTF-8 definition if it is still disabled in locale.gen.
sed -i 's/^#\s*\(en_US\.UTF-8 UTF-8\)$/\1/' "$locale_gen"

# Generate locale data inside the target system and choose it for login shells
# and services on the installed system.
arch-chroot "$archmount" locale-gen
printf 'LANG=en_US.UTF-8\n' > "$archmount/etc/locale.conf"
printf 'KEYMAP=us\n' > "$archmount/etc/vconsole.conf"
