# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ pkgs, ... }:

{
  environment.systemPackages = with pkgs;
  let
    system-python-packages = python-packages: with python-packages; [
      docker_compose
      numpy
      requests
    ];
    system-python = python3.withPackages system-python-packages;
  in [
    system-python # defines the system python installation
    pipenv # convenient npm-like python packaging
  ];
}
