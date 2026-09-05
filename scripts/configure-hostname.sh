#!/usr/bin/env bash

# This script is sourced after the target system is mounted at archmount. The
# hostname is collected by install.sh before the installation steps begin.
: "${archmount:?archmount must be set before sourcing configure-hostname.sh}"
: "${host:?host must be set before sourcing configure-hostname.sh}"

# Keep the hostname file to a single line, as expected by systemd-hostnamed.
printf '%s\n' "$host" > "$archmount/etc/hostname"
