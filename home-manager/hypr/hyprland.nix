{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does
    ./waybar.nix

    # Split config into multiple files
    ./conf
  ];

  home.packages = with pkgs; [
    unstable.hyprshutdown
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

  services.dunst.enable = true; # notification manager
  programs.hyprshot.enable = true; # screenshot manager

  programs.hyprlock.enable = true;
  xdg.configFile.hyprlock = {
    source = ./hyprlock.conf;
    target = "hypr/hyprlock.conf";
  };

  services.hypridle.enable = true;
  xdg.configFile.hypridle = {
    source = ./hypridle.conf;
    target = "hypr/hypridle.conf";
  };

  services.hyprpaper.enable = true; # dynamic wallpaper manager
  services.hyprpaper.settings = {
    wallpaper = [
      ",path = ../../assets/planet-bottom.jpg"
    ];
  };
  programs.wlogout.enable = true;
}
