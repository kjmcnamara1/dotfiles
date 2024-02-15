#!/usr/bin/env bash

# ln -s "$(pwd)/.gitconfig" ~/.gitconfig
# ln -sd "$(pwd)/.config/nvim" ~/.config/nvim

for file in .*; do
  if [ "$file" = '.git' ]; then
    continue
  fi
  echo "$file"
done

