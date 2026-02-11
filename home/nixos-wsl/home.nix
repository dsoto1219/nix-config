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

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
}

