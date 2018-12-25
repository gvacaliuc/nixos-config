# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./common/i3.nix
      ./common/docker.nix
      ./common/python.nix
      ./common/go.nix
    ];

  nixpkgs.config = {
    # allow unfree
    allowUnfree = true;
    firefox.icedtea = true;
  };
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # configure networking
  networking.hostName = "hydrogen"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  # configure nameservers
  #networking.nameservers = [ "1.1.1.1" ];

  # Select internationalisation properties.
  # i18n = {
  #   consoleFont = "Lat2-Terminus16";
  #   consoleKeyMap = "us";
  #   defaultLocale = "en_US.UTF-8";
  # };

  # timezone = null allows for imperative configuration:
  # https://github.com/NixOS/nixpkgs/issues/26469
  #   $ timedatectl set-timezone America/Chicago
  time.timeZone = null;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  # environment.systemPackages = with pkgs; [
  #   wget vim
  # ];
  
  environment = {
    systemPackages = with pkgs; [
      # hardware sensors
      lm_sensors

      # rice vpn
      openconnect

      firefox
      bash
      bash-completion
      networkmanager
      networkmanagerapplet
      git
      vim
      wget
      which
      gnupg
      arandr
      curl
      pkgs.gnome3.gnome-terminal
      
      gnome2.gnomeicontheme # more icons
      hicolor-icon-theme # icons for nm-applet +
      shared_mime_info
      
     #xfce.exo
     #xfce.gtk-xfce-engine
     #xfce.gvfs            # auto mounting
     #xfce.libxfce4ui
     #xfce.libxfcegui4
     #xfce.xfce4-settings
     #xfce.xfconf
     #xfce.xfce4-mixer
     #xfce.xfce4-pulseaudio-plugin
     #xfce.xfce4-mpc-plugin
      
      zathura              # pdf viewer
      xorg.xbacklight # xbacklight

      # WWJ Stuff
      xorg.libXxf86vm
    ];
  
    # /var/run/current-system/sw/etc/profile
    shellInit = ''
      # ===================================
      # SYSTEM WIDE CONFIGURATION GOES HERE
      # ===================================
      # Set GTK_PATH so that GTK+ can find the Xfce theme engine.
      #export GTK_PATH=${pkgs.xfce.gtk-xfce-engine}/lib/gtk-2.0
      
      # Set GTK_DATA_PREFIX so that GTK+ can find the Xfce themes.
      #export GTK_DATA_PREFIX=${config.system.path}
      # Set GIO_EXTRA_MODULES so that gvfs works.
      #export GIO_EXTRA_MODULES=${pkgs.xfce.gvfs}/lib/gio/modules
      # Launch xfce settings daemon.
      # xfsettingsd &
      # ===================================
    '';

    pathsToLink =
      [ "/share/xfce4" "/share/themes" "/share/mime" "/share/desktop-directories"];

    sessionVariables.TERMINAL = [ "gnome-terminal" ];
  };
  
  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.hplip ];

  # set pulseaudio
  sound.enable = true;
  nixpkgs.config.pulseaudio = true;
  hardware.pulseaudio = {
    enable = true;
    package = pkgs.pulseaudioFull;
  };

  # setup bluetooth
  hardware.bluetooth.enable = true;

  # enable opengl
  hardware.opengl = {
    enable = true;
  };

  # enable virtualbox
  virtualisation.virtualbox.host.enable = true;

  fonts = {
    enableFontDir = true;
    enableGhostscriptFonts = true;
    fonts = with pkgs; [
      corefonts
      cm_unicode
      dejavu_fonts
      freefont_ttf
      inconsolata
      liberation_ttf
      libertine
      terminus_font
      ttf_bitstream_vera
      vistafonts
    ];
  };

  users.extraUsers.gvacaliuc = {
    createHome = true;
    extraGroups = ["wheel" "video" "audio" "disk" "networkmanager" "udev"];
    group = "users";
    home = "/home/gvacaliuc";
    isNormalUser = true;
    uid = 1000;
  };

  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "18.09"; # Did you read the comment?
}
