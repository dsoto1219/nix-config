# Users shared across all machines.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true;

  users = {
    users = {
      danim = {
        isNormalUser = true;
        extraGroups = [ "networkmanager" "wheel" "input" ]; # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      };
    };
    defaultUserShell = pkgs.zsh;
  };

  # Import home-manager configuration
  home-manager.users.danim = import ../../home/danim/home.nix;
}

