# Configuration file for nixos-wsl
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  wsl.enable = true;
  wsl.defaultUser = "nixos";

  networking.hostName = "nixos";
}
