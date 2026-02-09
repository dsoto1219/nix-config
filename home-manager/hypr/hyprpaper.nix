{ ... }:
{
  services.hyprpaper.enable = true; # dynamic wallpaper manager
  services.hyprpaper.settings = {
    preload = [
      "~/nix-config/assets/house-in-middle-of-mountain.jpg"
    ];
    wallpaper = [
      # By default/fallback
      ",~/nix-config/assets/house-in-middle-of-mountain.jpg"
    ];
  };
}
