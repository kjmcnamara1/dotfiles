#!/usr/bin/env bash

# This script is sourced after the target system has been mounted and bootstrapped.
: "${archmount:?archmount must be set before sourcing configure-users.sh}"
: "${admin_username:?admin_username must be set before sourcing configure-users.sh}"

if [[ ! "$admin_username" =~ ^[a-z_][a-z0-9_-]*\$?$ ]]; then
  echo "Admin username must be a valid local Linux username." >&2
  return 2
fi

# install.sh enables xtrace for ordinary installer diagnostics. Disable it only
# while handling passwords, so neither a pipeline nor an expanded command can
# reveal a secret in the terminal or its log.
case $- in
  *x*)
       restore_xtrace=1
                         set +x
                                ;;
  *) restore_xtrace=0 ;;
esac

if [ -z "${root_password:-}" ] || [ -z "${admin_password:-}" ]; then
  echo "Root and admin passwords must not be empty." >&2
  if [ "$restore_xtrace" -eq 1 ]; then
    set -x
  fi
  return 2
fi

printf 'root:%s\n' "$root_password" | arch-chroot "$archmount" chpasswd

if arch-chroot "$archmount" id -u "$admin_username" > /dev/null 2>&1; then
  arch-chroot "$archmount" usermod -aG wheel,input,video,scanner "$admin_username"
else
  arch-chroot "$archmount" useradd -m -G wheel,input,video,scanner "$admin_username"
fi
printf '%s:%s\n' "$admin_username" "$admin_password" \
                                                     | arch-chroot "$archmount" chpasswd

install -d -m 0750 "$archmount/etc/sudoers.d"
printf '%s ALL=(ALL:ALL) NOPASSWD: ALL\n' "$admin_username" \
  > "$archmount/etc/sudoers.d/00-$admin_username"
chmod 0440 "$archmount/etc/sudoers.d/00-$admin_username"
arch-chroot "$archmount" visudo -cf "/etc/sudoers.d/00-$admin_username"

unset root_password admin_password
if [ "$restore_xtrace" -eq 1 ]; then
  set -x
fi
