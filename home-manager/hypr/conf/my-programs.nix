###################
### MY PROGRAMS ###
###################

# See https://wiki.hypr.land/Configuring/Keywords/
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
  ];

  programs.kitty.enable = true;
  programs.wofi.enable = true; # menu manager 

  wayland.windowManager.hyprland.settings = {
    # Set programs that you use
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "wofi --show drun";
  };
}
