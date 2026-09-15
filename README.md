# Dotfiles

## Installation

```sh
# Increase size of archiso CopyOnWrite filesystem
mount -o remount,size=2G /run/archiso/cowspace

pacman -Sy --noconfirm chezmoi git
chezmoi init --depth 1 --branch dots kjmcnamara1

chezmoi cd
./install.sh
```

```sh
chezmoi init --branch dots kjmcnamara1
chezmoi apply --include=scripts
```

## Niri vs Hyprland

| Category   | Feature                                                             | Niri |   Hyprland   |
| ---------- | ------------------------------------------------------------------- | :--: | :----------: |
| workspaces | Multiple layouts                                                    |      |      x       |
| workspaces | Scrolling layout                                                    |  x   |      x       |
| workspaces | First window on scrolling layout auto-maximizes                     |      |      x       |
| workspaces | Vertical tabbed groups                                              |  x   |              |
| workspaces | Ability to autofit windows on screen                                |      |      x       |
| workspaces | Fullscreen windows in scrolling layout                              |  x   |      x       |
| workspaces | Output-bounded dynamic workspaces                                   |  x   |    hacky     |
| workspaces | Window Switcher (alt-tab)                                           |  x   |              |
| workspaces | Overview (Expose)                                                   |  x   |     ugly     |
| workspaces | Special workspaces (scratchpad)                                     |      |      x       |
| window     | Minimize windows                                                    |      |      x       |
| window     | Pseudo tiling                                                       |      |      x       |
| window     | Pin windows (float and follow when switching workspaces)            |      |      x       |
| window     | Force kill window                                                   |      |      x       |
| window     | Window tags                                                         |      |      x       |
| appearance | Transparency and blur                                               |  x   |      x       |
| input      | Touchpad gestures                                                   |  x   |  not smooth  |
| input      | Keybind submaps / chords                                            |      |      x       |
| input      | Global keybinds (pass/send shortcut to any app)                     |  ?   |      x       |
| config     | Dynamically change config properties (gaps, borders, gamemode, etc) |      |      x       |
| config     | Config language                                                     | kdl  |     lua      |
| outputs    | Fake outputs                                                        |  ?   |      x       |
| bug        | Lock Screen crashes (hyprlock and dms)                              |  x   |              |
| system     | Systemd integration                                                 |  x   | questionable |
