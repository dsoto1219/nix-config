{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does

    # Split config into multiple files
    ./conf
    ./extra
  ];

  # Enable hyprland
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.variables = ["--all"];
  };
}
