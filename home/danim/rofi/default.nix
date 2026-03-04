{ pkgs, ... }:
{
  stylix.targets.rofi.enable = false;

  programs.rofi = {
    enable = true; # application launcher
    theme = "Monokai";
  };
}
