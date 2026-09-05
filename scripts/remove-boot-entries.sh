#!/usr/bin/env bash

# [x] Remove all EFI boot entries
for entry in $(efibootmgr | grep '^Boot[0-9]' | awk -F'[* ]' '{print substr($1,5)}'); do
  sudo efibootmgr -b "$entry" -B
done
