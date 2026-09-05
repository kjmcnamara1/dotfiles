#!/usr/bin/env bash

# This script is sourced after the base system is installed at archmount.
# Look up the public IP's IANA timezone, then configure that timezone in the
# target system and enable systemd's NTP synchronization service.
: "${archmount:?archmount must be set before sourcing configure-time.sh}"

# ipapi.co returns a single IANA timezone name (for example, America/New_York).
# Time out promptly rather than continuing an installation with a stalled lookup.
timezone=$(curl --fail --silent --show-error --max-time 10 https://ipapi.co/timezone)

# Accept only an IANA-style path and require a matching zoneinfo file in the
# target system. This prevents a network response from becoming a path argument.
if [[ ! "$timezone" =~ ^[[:alnum:]_.+-]+(/[[:alnum:]_.+-]+)+$ ]] || \
  [ ! -e "$archmount/usr/share/zoneinfo/$timezone" ]; then
  echo "Could not determine a valid timezone from the current public IP." >&2
  return 1
fi

# A symlink is the normal Arch Linux timezone configuration. systemd-timesyncd
# is available in the base system and will synchronize time after first boot.
arch-chroot "$archmount" ln -sf "/usr/share/zoneinfo/$timezone" /etc/localtime
# Store the current system time in the machine's battery-backed hardware clock.
arch-chroot "$archmount" hwclock --systohc
arch-chroot "$archmount" systemctl enable systemd-timesyncd.service

echo "Timezone set to $timezone; systemd-timesyncd enabled."
