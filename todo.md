# To Do

## Hyprland

- [x] Split hyprland.conf into multiple files?
- [ ] Move windowrules to separate file
- [ ] Desktop entries for TUIs and Web Apps
- [ ] Simplify starship prompt

### Write scripts

- [ ] System update (pacman/yay)
- [x] Wifi (impala)
- [x] Bluetooth (bluetui)
- [x] Monitors (hyprmon)

### Rofi

- [ ] Power menu
- [ ] Applications
- [ ] Monitor profiles
- [ ] Keybinds
- [ ]

## Theming

- [ ] use adw-gtk3-dark theme
- [ ] generate ansinord gtk.css files from wallust
  - [ ] ~/.config/gtk-3.0/gtk.css
  - [ ] ~/.config/gtk-4.0/gtk.css
- [ ] Nordzy-cursors
- [ ] Sans serif font (Fira sans?)
- [ ] Prefer dark theme

### Waybar

- [ ] Solid bar all the way across
- [ ] Date/time in center with update system indicator 
- [ ] Workspaces on left (include numbers?)
- [ ] Widgets on right (wifi, bluetooth, monitors, battery)
- [ ] tweak window title
- [ ] fix wallust/nord colors

### Notifications

- [x] No SwayNC
- [x] Use mako
- [x] Wallust for mako
- [x] SwayOSD for onscreen volume/mute/brightness

### Visual Studio Code

- [ ] Integrate wallust theme

### Wallpaper

- [x] waypaper changes wallpaper without running wallust
- [x] on start hyprland: only load last waypaper wallpaper. don't run wallust
- [ ] load wallpaper on autologin before hyprlock executes

## Chezmoi

write scripts for files outside home dir OR use [rootmoi](https://github.com/twpayne/chezmoi/discussions/1510#discussioncomment-7808924)
use specific `sudo chezmoi` commands for relevant files/directories

- [x] sddm
- [ ] interception
- [ ] fstab
- [ ] nsswitch.conf (printing)
- [ ] pacman.conf
