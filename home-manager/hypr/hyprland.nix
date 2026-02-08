{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does

    # Split config into multiple files
    ./conf
    ./extra
  ];

  # Hyprland Configuration
  wayland.windowManager.hyprland = let
    hyprland-pkgs = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    enable = true;
    # set the flake package
    package = hyprland-pkgs.hyprland; 
    portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland; 
    systemd.variables = ["--all"];
  };
}
