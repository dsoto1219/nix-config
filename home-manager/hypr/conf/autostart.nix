#################
### AUTOSTART ###
#################

# Autostart necessary processes (like notifications daemons, status bars, etc.)
{ ... }:
{
  wayland.windowManager.hyprland.settings = {
    # Or execute your favorite apps at launch like this:
    exec-once = [
      "hyprlock || hyprctl dispatch exit"
      # "$terminal"
      "waybar & hyprpaper"
      # "nm-applet &"
      "systemctl --user start hyprpolkitagent"
      "hypridle"
    ];
  };
}


