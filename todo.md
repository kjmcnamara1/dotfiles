# To Do

## Kitty

- [x] Clean up config directory
- [ ] Customize keybinds
- [x] [kitty-scrollback.nvim](https://github.com/mikesmithgh/kitty-scrollback.nvim)
- [x] [smart-splits.nvim](https://github.com/mrjones2014/smart-splits.nvim)

## Hyprland

- [ ] Screenshot support (grim/slurp/grimblast?)
- [x] Systemd wants instead of exec-once in hyprland.conf
- [x] Split hyprland.conf into multiple files?
- [ ] Move windowrules to separate file
- [ ] Better keybinds for moving around windows/monitors/workspaces (mimic
      cosmic)
- [x] Desktop entries for TUIs
- [ ] Desktop entries for Web Apps
- [x] Simplify starship prompt
- [x] Xonsh as main shell?
- [x] Switch to kitty/ghostty as primary terminal
  - [x] Pyprland scratchpads
  - [x] Waybar TUIs
  - [x] Images in FzfLua in neovim and Yazi
  - [x] Use neovim as scrollback buffer
  - [ ] Keybinds for splits/multiplexing etc.

### Write scripts

- [x] System update (pacman/yay)
- [x] Wifi (impala)
- [x] Bluetooth (bluetui)
- [x] Monitors (hyprmon)
- [ ] Print settings???

### Launcher

- [x] Walker/elephant? or Rofi
- [x] Power menu for rofi
- [x] Applications
- [x] Monitor profiles
- [x] Keybinds
- [ ] Wofi?

### Monitor configuration

Python TUI for configuring hyprland/sway/niri monitors  
Similar to [hyprmon](https://github.com/erans/hyprmon)

## Theming

- [ ] Use matugen instead?
- [x] use adw-gtk3-dark theme
- [ ] generate ansinord gtk.css files from wallust
  - [ ] ~/.config/gtk-3.0/gtk.css
  - [ ] ~/.config/gtk-4.0/gtk.css
- [ ] Nordzy-cursors
- [ ] Sans serif font (Fira sans?)
- [ ] Prefer dark theme

### Waybar

- [x] Solid bar all the way across
- [x] Date/time in center with update system indicator 
- [x] Workspaces on left (include numbers?)
- [x] Widgets on right (wifi, bluetooth, monitors, battery)
- [c] Get window title separate-outputs to work
- [x] fix wallust/nord colors
- [ ] add weather widget (maybe [wttrbar](https://github.com/bjesus/wttrbar))

### Notifications

- [x] No SwayNC
- [x] Use mako
- [x] Wallust for mako
- [x] SwayOSD for onscreen volume/mute/brightness

### Visual Studio Code

- [ ] Integrate wallust/matugen theme

### Wallpaper

- [x] waypaper changes wallpaper without running wallust
- [x] on start hyprland: only load last waypaper wallpaper. don't run wallust
- [ ] load wallpaper on autologin before hyprlock executes

## Chezmoi

write scripts for files outside home dir OR use [rootmoi](https://github.com/twpayne/chezmoi/discussions/1510#discussioncomment-7808924)
use specific `sudo chezmoi` commands for relevant files/directories

- [x] sddm
- [x] interception
- [x] fstab
- [x] nsswitch.conf (printing)
- [x] pacman.conf

## Neovim

- [x] Split config into profiles
  - [x] Base/core for popups (common to all)
  - [x] VS Code
  - [x] Full/Neovim
