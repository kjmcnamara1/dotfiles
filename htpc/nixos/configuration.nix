# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.permittedInsecurePackages = [
  #   "freeimage-unstable-2021-11-01"
  # ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "quiet"
    "splash"
  ];
  boot.plymouth.enable = true;

  networking.hostName = "htpc"; # Define your hostname.
  networking.wireless.iwd.enable = true;
  # networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
  # services.gnome.gnome-keyring.enable = true;

  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      addresses = true;
      userServices = true;
      workstation = true;
    };
  };

  # Set your time zone.
  time.timeZone = "US/Eastern";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.interception-tools = {
    enable = true;
    plugins = with pkgs.interception-tools-plugins; [ caps2esc ];
    udevmonConfig = ''
      - JOB: ${pkgs.interception-tools}/bin/intercept -g $DEVNODE | ${pkgs.interception-tools-plugins.caps2esc}/bin/caps2esc -m 1 | ${pkgs.interception-tools}/bin/uinput -d $DEVNODE
        DEVICE:
          NAME: AT Translated Set 2 keyboard
    '';
  };

  # services.getty.autologinUser = "htpc";
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd}/bin/agreety --cmd Hyprland";
      };
      initial_session = {
        command = "${pkgs.hyprland}/bin/Hyprland";
        user = "htpc";
      };
    };
  };
  programs.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
    portalPackage =
      inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
  };

  programs.niri.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  # services.flatpak.enable = true;
  programs.appimage.enable = true;
  programs.appimage.binfmt = true;
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  programs.steam.enable = true;

  security.sudo.wheelNeedsPassword = false;
  fileSystems."/mnt/NAS" = {
    device = "snow.local:/mnt/md1";
    fsType = "nfs";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.htpc = {
    isNormalUser = true;
    description = "htpc";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    packages = with pkgs; [
      vacuum-tube
      plex-htpc
      flex-launcher
      protonvpn-gui # need NetworkManager.service running in order to connect to a vpn server
      # emulationstation-de
      # pegasus-frontend
      (retroarch.withCores (
        cores: with cores; [
          mesen
          snes9x
        ]
      ))
      cemu
      ryubing
      snes9x
      lutris
      steam
      sc-controller
      input-remapper
      brave
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # programs.bash = {
  #   enable = true;
  #   loginShellInit = "exec hyprland";
  # };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    git
    chezmoi
    wget
    curl
    kitty
    fd
    fzf

    yazi
    ffmpeg
    mediainfo
    p7zip
    poppler
    resvg
    imagemagick
    glow
    ouch

    impala

    nfs-utils

    rofi
    nautilus

    bottles

    nixd
    nixfmt
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

}
