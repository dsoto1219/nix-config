{ ... }:
{
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = let
    wallpaper-path = "../../../assets/ksp-wallpaper.png";
  in {
    preload = [ wallpaper-path ];
    wallpaper = [
      ",${wallpaper-path}"
    ];
  };
}
