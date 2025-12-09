# Users shared across all machines.
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  programs.zsh.enable = true; # want zsh to be the default shell

  users.users = {
    danim = {
      isNormalUser = true;
      extraGroups = [ "networkmanager" "wheel" ]; # Be sure to add any other groups you need (such as networkmanager, audio, docker, etc)
      shell = pkgs.zsh;
    };
  };
}

