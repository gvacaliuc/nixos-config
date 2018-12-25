# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  virtualisation.docker.enable = true;
  users.users.gvacaliuc.extraGroups = [ "docker" ];

  environment.systemPackages = with pkgs; [
    docker_compose
  ];
}
