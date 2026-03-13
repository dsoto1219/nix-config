{ ... }:
{
  services.hyprpaper.enable = true;

  services.hyprpaper.settings = let
    wallpaper-path = "../../../assets/sekiro-vs-father-sunset.png";
  in {
    preload = [ wallpaper-path ];
    wallpaper = [
      ",${wallpaper-path}"
    ];
  };
}
