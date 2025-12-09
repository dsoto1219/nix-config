{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
username = "danim";
in {
  home = {
    inherit username;
    homeDirectory = "/home/${username}";
  };
}

