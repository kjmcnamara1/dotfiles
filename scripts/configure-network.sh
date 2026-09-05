#!/usr/bin/env bash

# Carry the ArchISO network configuration into the new system. iwd's saved
# network files contain the Wi-Fi credentials created by iwctl during this
# install; NetworkManager will use iwd as its Wi-Fi backend.
: "${archmount:?archmount must be set before sourcing configure-network.sh}"

copy_network_config() {
  local source=$1
  local destination=$2
  local mode=$3

  [ -d "$source" ] && [ -r "$source" ] || return 0
  install -d -m "$mode" "$destination"
  cp -a "$source"/. "$destination"/
}

# Preserve explicitly configured addresses, DNS settings, and Wi-Fi profiles
# from the running ArchISO. Do not copy /etc/resolv.conf: the installed system
# gets its own runtime resolver state below.
copy_network_config /etc/systemd/network "$archmount/etc/systemd/network" 0755
copy_network_config /etc/systemd/resolved.conf.d \
  "$archmount/etc/systemd/resolved.conf.d" 0755
if [ -f /etc/systemd/resolved.conf ]; then
  install -D -m 0644 /etc/systemd/resolved.conf \
    "$archmount/etc/systemd/resolved.conf"
fi
copy_network_config /etc/NetworkManager "$archmount/etc/NetworkManager" 0755
copy_network_config /etc/iwd "$archmount/etc/iwd" 0755
copy_network_config /var/lib/iwd "$archmount/var/lib/iwd" 0700

# NetworkManager owns all interfaces on the installed system. Its iwd backend
# starts and manages iwd itself, so neither standalone iwd nor networkd may be
# enabled alongside it.
arch-chroot "$archmount" pacman -S --needed --noconfirm NetworkManager iwd
install -d "$archmount/etc/NetworkManager/conf.d"
cat > "$archmount/etc/NetworkManager/conf.d/10-iwd.conf" <<'EOF'
[main]
dns=systemd-resolved

[device]
wifi.backend=iwd
EOF
arch-chroot "$archmount" systemctl disable systemd-networkd.service iwd.service
arch-chroot "$archmount" systemctl enable \
  NetworkManager.service systemd-resolved.service
ln -sfn /run/systemd/resolve/stub-resolv.conf "$archmount/etc/resolv.conf"
