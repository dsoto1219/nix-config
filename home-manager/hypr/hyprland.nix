{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does
    ./waybar.nix
    ./conf/monitors.nix
  ];

  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    unstable.hyprshutdown
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = let
    hyprland-pkgs = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    enable = true;
    # set the flake package
    package = hyprland-pkgs.hyprland; 
    portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland; 
    systemd.variables = ["--all"];
    extraConfig = builtins.readFile ./conf/hyprland.conf;
  };

  services.dunst.enable = true; # notification manager
  programs.wofi.enable = true; # menu manager 

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
