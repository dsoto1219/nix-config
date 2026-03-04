{ pkgs, ... }:
{
  programs.rofi = {
    enable = true; # application launcher
    # theme = builtins.readFile "${pkgs.rofi}/share/rofi/themes/Monokai.rasi";
  };
}
