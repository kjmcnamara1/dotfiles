#!/usr/bin/env bash

# This script is sourced after the base system is installed at archmount.
# Determine the public IP's IANA timezone, then configure that timezone in the
# target system and enable systemd's NTP synchronization service.
: "${archmount:?archmount must be set before sourcing configure-time.sh}"

valid_timezone() {
  [[ "$1" =~ ^[[:alnum:]_.+-]+(/[[:alnum:]_.+-]+)+$ ]] \
                                                       && [ -e "$archmount/usr/share/zoneinfo/$1" ]
}

# Each provider sees the request's public IP. The first two have compact
# plaintext timezone endpoints; ipwho.is provides an independent JSON fallback.
detect_timezone() {
  local candidate

  for provider in ipapi ipinfo ipwhois; do
    case "$provider" in
      ipapi)
        candidate=$(curl --fail --silent --max-time 10 \
          https://ipapi.co/timezone 2> /dev/null) || continue
        ;;
      ipinfo)
        candidate=$(curl --fail --silent --max-time 10 \
          https://ipinfo.io/timezone 2> /dev/null) || continue
        ;;
      ipwhois)
        candidate=$(curl --fail --silent --max-time 10 https://ipwho.is/ 2> /dev/null \
                                                                                     | jq --raw-output '.timezone.id // empty' 2> /dev/null) || continue
        ;;
    esac

    if valid_timezone "$candidate"; then
      printf '%s\n' "$candidate"
      return 0
    fi
  done
  return 1
}

timezone=$(detect_timezone) || timezone=''
if [ -n "$timezone" ]; then
  echo "Detected timezone from public IP: $timezone"
else
  echo "Could not determine a valid timezone from the current public IP." >&2
  while ! valid_timezone "$timezone"; do
    read -rp "Timezone (for example, America/New_York): " timezone || return 1
    if ! valid_timezone "$timezone"; then
      echo "'$timezone' is not a valid timezone in the target system." >&2
    fi
  done
fi

# A symlink is the normal Arch Linux timezone configuration. systemd-timesyncd
# is available in the base system and will synchronize time after first boot.
arch-chroot "$archmount" ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
# Store the current system time in the machine's battery-backed hardware clock.
arch-chroot "$archmount" hwclock --systohc
arch-chroot "$archmount" systemctl enable systemd-timesyncd.service

echo "Timezone set to $timezone; systemd-timesyncd enabled."
