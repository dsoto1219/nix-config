{ ... }:
{
  services.hyprpaper.enable = true; # dynamic wallpaper manager
  services.hyprpaper.settings = {
    preload = [
      "~/nix-config/assets/planet-bottom.jpg"
    ];
    wallpaper = [
      # By default/fallback
      ",~/nix-config/assets/planet-bottom.jpg"
    ];
  };
}
