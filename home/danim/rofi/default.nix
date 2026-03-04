{ pkgs, ... }:
{
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true; # application launcher
    theme = builtins.readFile "${pkgs.rofi}/share/rofi/themes/Monokai.rasi";
  };
}
