###################
### MY PROGRAMS ###
###################

# See https://wiki.hypr.land/Configuring/Keywords/
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Set programs that you use
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "wofi --show drun";
  };
}
