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
      "nm-applet &"
      "systemctl --user start hyprpolkitagent"
      "hypridle"
      # https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
      "systemd-inhibit --who=\"Hyprland config\" --why=\"wlogout keybind\" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit"
    ];

    exec-shutdown = [
      "kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)\""
    ];
  };
}


