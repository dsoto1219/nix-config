{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
username = "nixos";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}

