# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

#My Crap
  {
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  programs.dconf.enable = true;
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
  };
  programs.zsh.enable = true;
  virtualisation.docker = {
    enable = true;
    daemon.settings.features.containerd-snapshotter = true;
    logDriver = "json-file";
  };
  security.sudo.wheelNeedsPassword = false;
  services.printing.enable = true;
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
   extraPortals = [ pkgs.xdg-desktop-portal-gtk ];
  };
  programs.neovim = {
    enable = true;
    defaultEditor = true;
  };
  services.avahi.enable = true;

  services.xrdp.enable = true;
  services.xrdp.defaultWindowManager = "lightdm";
  services.xrdp.openFirewall = true;

  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.binfmt = {
    emulatedSystems = [ "aarch64-linux" "armv7l-linux" ];
    preferStaticEmulators = true;
  };

  # boot.plymouth.enable = true; 
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  networking.hostName = "remote"; # Define your hostname.
  networking.wireless.enable = false;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = false;
  networking.useDHCP = true;
#  networking.bridges = {
#    "br0" = {
#      interfaces = [ "enp3s0" ];
#    };
#  };
#  networking.interfaces.br0.ipv4.addresses = [ {
#    address = "10.10.10.4";
#    prefixLength = 24;
#  } ];
#  networking.defaultGateway = "10.10.10.1";
#  networking.nameservers = ["10.10.10.1"];

  # Set your time zone.
  time.timeZone = "Europe/Amsterdam";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nl_NL.UTF-8";
    LC_IDENTIFICATION = "nl_NL.UTF-8";
    LC_MEASUREMENT = "nl_NL.UTF-8";
    LC_MONETARY = "nl_NL.UTF-8";
    LC_NAME = "nl_NL.UTF-8";
    LC_NUMERIC = "nl_NL.UTF-8";
    LC_PAPER = "nl_NL.UTF-8";
    LC_TELEPHONE = "nl_NL.UTF-8";
    LC_TIME = "nl_NL.UTF-8";
  };

  services.xserver = {
    enable = true;
    windowManager.i3.package = pkgs.i3-gaps;

    desktopManager = {
      xterm.enable = false;
    };
   
    displayManager = {
       defaultSession = "none+i3";
    };

    windowManager.i3 = {
      enable = true;
      extraPackages = with pkgs; [
        dmenu #application launcher most people use
        i3status # gives you the default i3 status bar
        i3lock #default i3 screen locker
        i3blocks #if you are planning on using i3blocks over i3status
     ];
    };
  };

# Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
};

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ronald = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Ronald van Kouwen";
    extraGroups = [ "wheel" "docker" "dialout" "scanner" "lp" ];
    packages = with pkgs; [];
  };

  users.users.xantios = {
    shell = pkgs.zsh;
    isNormalUser = true;
    description = "Xantios Krugor";
    extraGroups = [ "wheel" "docker" "dialout" "scanner" "lp" ];
    packages = with pkgs; [];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  xrdp
  avahi
  picom
  killall
  playerctl
  neovim
  cifs-utils
  feh
  htop
  pulseaudio
  pavucontrol
  nemo
  firefox
  thunderbird
  rxvt-unicode
  unzip
  bash
  wget
  git
  remmina
  gnumake
  wineWowPackages.stable
  winetricks
  xsane
  qemu
  docker
  docker-buildx
  gtk3
  python3Full
  libreoffice
  ];

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?

}
