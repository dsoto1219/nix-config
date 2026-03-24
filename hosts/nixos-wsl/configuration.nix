# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

# NixOS-WSL specific options are documented on the NixOS-WSL repository:
# https://github.com/nix-community/NixOS-WSL

{ config, lib, pkgs, ... }:

{
  imports = [
    ../default.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";
  
  wsl.docker-desktop.enable = true;

  networking.hostName = "nixos";

  programs.zsh.enable = true;
  users.users.nixos.defaultUserShell = pkgs.zsh;

  home-manager.users.nixos = import ../../home/nixos-wsl/home.nix;
}
