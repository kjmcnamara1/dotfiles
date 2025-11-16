# dotfiles

## Login Manager

- sddm

## Package manager

- yay

## Desktop Environment

[Hyprland](https://wiki.hypr.land/)
hyprlock
hypridle
pyprland
waybar
uwsm - Universal Wayland Session Manager

### Launcher

walker
rofi
ulauncher

## Fonts

- [JetBrains Mono](https://www.programmingfonts.org/#jetbrainsmono)

## Editors

- [Neovim](https://neovim.io/)
- [Helix](https://helix-editor.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Zed](https://zed.dev/)

## Shell Tools

### [fzf](https://junegunn.github.io/fzf/)

zoxide
ripgrep
eza
fd
fzf
fastfetch
bat
jq
fish
xonsh
zsh
starship
github-cli

## Terminal

- wezterm
- ghostty
- alacritty

## TUIs

### Network

- [Impala](https://github.com/pythops/impala) - TUI for managing wifi on Linux
- [Bluetui](https://github.com/pythops/bluetui) - TUI for managing bluetooth on Linux

- [Dust](https://github.com/bootandy/dust) - A more intuitive version of du in rust
- lazygit
- lazydocker
- caligula - burn iso to usb

### Task manager

- btop
- bottom

### Files

- Yazi

## GUIs

- Obsidian
- Pinta
- LocalSend
- MegaSync
- Thunar - file manager
- nwg-look
- nwg-displays

### Office

- LibreOffice
- OnlyOffice

### Messaging

- Signal

### Media

- mpv - video player
- OBS Studio - screen recording
- Kdenlive - video editor

## Hotkeys

| Key            | Action          |
| -------------- | --------------- |
| `Super+c`      | Close window    |
| `Super+Return` | Launch terminal |

## Web Apps

- Proton Mail
- Proton Calendar
- Proton Pass
- Proton Drive
- X
- Youtube
- WhatsApp

## Theme

- wallust - ansinord
- waypaper - desktop background/wallpaper

## Gaming

- Steam
- Lutris

## Python

- uv

## Arch Linux

### Installation

Make sure to UEFI Boot from live USB

#### [Connect to Wifi](https://wiki.archlinux.org/title/Iwd#iwctl)

```sh
iwctl
station wlan0 get-networks # Scan/List networks
station wlan0 connect SSID # Connect to network
```

Enter passphrase when prompted.

```sh
station wlan0 show # Confirm connection
exit # Exit back to commandline
```

#### Automated Install Script

```sh
# mount -m -t nfs snow.local:/mnt/md1 /nas # to save config file to nas
mount -m -t cifs //192.168.0.10/NAS /nas -o username=admin # cifs-utils comes packaged with archiso
bash -c "$(curl -s https://raw.githubusercontent.com/kjmcnamara1/dotfiles/refs/heads/main/arch/install)"
# curl -s https://raw.githubusercontent.com/kjmcnamara1/dotfiles/main/scripts/MUSE.sh > /tmp/tmp.sh
# bash /tmp/tmp.sh
```

Script will prompt for:

1. archinstall config name (default=muse)
2. root password
3. Admin username (default=kjm) and password

You will need to select options for disk layout.
Any other preconfigured options can be changed before beginning install.

Arch linux will be installed.

Select "No" when asked to chroot into the new installation.

Script will ask if you want to install chezmoi dotfiles.

Script will prompt to reboot.

### Configuration

Log in via tty with the Admin user credentials you supplied during the install script.

Connect to the internet with networkmanager tui:

```sh
nmtui
```

**Activate a connection** > Select Wi-Fi network > Enter _password_ > **OK** > **Back** > **Quit**

Clone dotfiles git repo and run:

```sh
git clone https://github.com/kjmcnamara1/dotfiles ~/dotfiles && cd ~/dotfiles
./dotbot muse cosmic
```

Login via login manager (e.g. sddm).

#### Change dotfiles repo to use SSH

```sh
gh auth login
git remote set-url origin git@github.com:kjmcnamara1/dotfiles
```

### OneDrive

```sh
onedrive
```

1. Paste URL into browser
2. Log in to MS OneDrive
3. Copy URL of addressbar of the blank page that results and paste into terminal

### Tmux

Start `tmux`

Install plugins
prefix (ctrl-a) + I (shift-i)

### QEMU

```sh
yay -S qemu virt-manager virt-viewer
yay -S dnsmasq vde2 bridge-utils openbsd-netcat iptables libguestfs
sudo usermod -aG libvirt $(whoami)
systemctl enable libvirtd
systemctl start libvirtd
```

