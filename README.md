# dotfiles

## Windows

1. Install [scoop](https://scoop.sh/)

```pwsh
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
```

1. Install optional applications
   - [Dell Active Pen Service](https://www.dell.com/support/home/en-us/product-support/product/dell-actv-pen-5000-series/drivers)
   - [Logi Options+](https://www.logitech.com/en-us/software/logi-options-plus.html)
   - MS Office 365
   - MS OneDrive / SharePoint
   - MS Teams
   - MS Outlook Web
   - [Proton Drive](https://proton.me/drive/download)
   - [Proton VPN](https://protonvpn.com/download-windows)
   - AMD software
   - Phone Link
1. Configure printers
1. Add scoop buckets
   ```
   scoop bucket add extras versions nerd-fonts nonportable
   ```
1. Install scoop packages
   ```
   scoop install JetBrainsMono-NF VictorMono-NF FiraCode-NF FiraCode-Script NerdFontsSymbolsOnly
   scoop install pwsh python poetry archwsl vscode wezterm win32yank peazip megasync
   ```

brave <!-- bucket extras -->
protonvpn-np <!-- bucket nonportable -->
office-365-apps-np <!-- bucket nonportable -->
freecad <!-- bucket extras -->
inkscape <!-- bucket extras -->
gimp <!-- bucket extras -->
obsidian <!-- bucket extras -->
git (maybe)
python <!-- bucket main v3.12.2 -->
poetry <!-- bucket main -->
python312 <!-- bucket versions -->
teamviewer <!-- bucket extras -->

peazip
archwsl
FiraCode-NF  
FiraCode-Script
JetBrainsMono-NF
VictorMono-NF  
NerdFontsSymbolsOnly
pwsh
vscode
wezterm  
win32yank

<!-- CascadiaCode-NF   -->
<!-- FiraCode   -->
<!-- IBMPlexMono-NF   -->
<!-- Iosevka-NF   -->
<!-- IosevkaTerm-NF   -->
<!-- JetBrains-Mono   -->
<!-- lazygit   -->
<!-- neovim-nightly   -->
<!-- nodejs   -->
<!-- ripgrep   -->
<!-- Victor-Mono   -->
<!-- zig -->

### WSL (Windows Subsystem for Linux)

carapace-bin
curl
fish
fzf
git
lazygit
man-db
neovim-nightly-bin
nodejs
npm
nushell
python-pipx
ripgrep
starship
tmux
unzip
wget
zoxide
zstd

## Arch
