# Arch Linux Installation

1. Boot from live USB in UEFI mode
2. Connect to Wi-Fi

   ```sh
   iwctl
   station wlan0 get-networks # Scan/List networks
   station wlan0 connect <SSID> # Connect to network
   ```

   Enter passphrase when prompted.

   ```sh
   station wlan0 show # Confirm connection
   exit # Exit back to commandline
   ```

## ArchInstall Script

```sh
curl -s https://raw.githubusercontent.com/kjmcnamara1/dotfiles/refs/heads/muse/arch/archinstall | bash -s -- muse
```

## Manual Script
