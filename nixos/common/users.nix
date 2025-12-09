# Users shared across all machines.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  users.users = {
    danim = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ]; # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
    };
  };
}

