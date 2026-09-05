# Installation

```sh
# Increase size of archiso CopyOnWrite filesystem
mount -o remount,size=2G /run/archiso/cowspace

pacman -Sy --noconfirm chezmoi git gum
chezmoi init --depth 1 --branch dots kjmcnamara1

chezmoi cd
./install.sh
```
