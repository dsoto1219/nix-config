{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: let
  username = "nixos";
in {
  imports = [
    ../default.nix
  ];

  home.username = username;
  home.homeDirectory = "/home/${username}";

  gtk.enable = false;
  dconf.enable = false;

  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-storm.yaml";
}

