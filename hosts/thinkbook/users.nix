# Users shared across all machines.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  users = {
    mutableUsers = false;

    users.danim = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" "input" ]; # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      hashedPasswordFile = "/var/lib/private/passwords/danim";
    };
  };

  # Import home-manager configuration
  home-manager.users.danim = ../../home/danim/home.nix;
}

