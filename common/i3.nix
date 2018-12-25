# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    rofi
    feh
    i3lock
    i3status
    scrot
  ];

  services.xserver = {
    enable = true;
    layout = "us";
    dpi = 192;

    windowManager = {
      i3.enable = true;
      default = "i3";
    };

    desktopManager = {
      default = "none";
      xterm.enable = false;
    };

    libinput = {
      enable = true;
      naturalScrolling = true;
      tapping = true;
      disableWhileTyping = true;
      horizontalScrolling = true;
    };

    multitouch = {
      enable = true;
      ignorePalm = true;
    };

    modules = [
      pkgs.xf86_input_wacom
    ];

    wacom.enable = true;
  };

  programs.dconf.enable = true;
  services.dbus.packages = [ pkgs.gnome3.dconf pkgs.gnome3.dconf-editor ];

  # Enable the KDE Desktop Environment.
  # services.xserver.displayManager.sddm.enable = true;
  # services.xserver.desktopManager.plasma5.enable = true;

}
