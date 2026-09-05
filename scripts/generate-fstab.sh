#!/usr/bin/env bash

# This script is sourced after the new system has been mounted at archmount.
# Generate a fresh, UUID-based fstab from that mount layout.
: "${archmount:?archmount must be set before sourcing generate-fstab.sh}"

fstab="$archmount/etc/fstab"
genfstab -U "$archmount" > "$fstab"

# Create the target directory now so the NFS mount has a destination on first
# boot, then add the NAS entry to the generated fstab.
mkdir -p "$archmount/mnt/NAS"
printf '\n# NAS\n192.168.0.10:/mnt/md1 /mnt/NAS nfs defaults,nofail 0 0\n' >> "$fstab"
