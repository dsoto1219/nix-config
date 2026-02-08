#############################
### ENVIRONMENT VARIABLES ###
#############################

# See https://wiki.hypr.land/Configuring/Environment-variables/
{ ... }:
{
  wayland.windowManager.hyprland.settings = let 
    cursor_size = 24;
  in {
    env = [
      "XCURSOR_SIZE,${cursor_size}"
      "HYPRCURSOR_SIZE,${cursor_size}"
    ];
  };
}

