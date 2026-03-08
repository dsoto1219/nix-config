{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "nixos";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
}

