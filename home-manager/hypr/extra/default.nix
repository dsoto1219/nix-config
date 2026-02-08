{ pkgs, ... }:
{
  imports = [
    ./waybar.nix
    ./wlogout.nix
  ];

  home.packages = with pkgs; [
    unstable.hyprshutdown
  ];

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
      ",path = ../../../assets/planet-bottom.jpg"
    ];
  };
}

