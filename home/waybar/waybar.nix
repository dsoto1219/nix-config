{ ... }: {

  programs.waybar.enable = true;
  programs.waybar.settings = [{
    layer = "top";
    position = "top";
    mod = "dock";
    exclusive = true;
    passtrough = false;
    gtk-layer-shell = true;
    height = 0;
    modules-left = [
      "hyprland/workspaces"
      "custom/file-manager"
      # "custom/divider"
      # "custom/weather"
      "custom/divider"
      "cpu"
      "custom/divider"
      "memory"
      "custom/media"
      "custom/divider"
    ];
    modules-center = [ "hyprland/window" ];
    modules-right = [
      "tray"
      "network"
      "custom/divider"
      "backlight"
      "custom/divider"
      "pulseaudio"
      "pulseaudio/slider"
      "custom/divider"
      "battery"
      "custom/divider"
      "clock"
      "custom/power"
    ];
    "hyprland/window" = { format = "{}"; };
    "wlr/workspaces" = {
      on-scroll-up = "hyprctl dispatch workspace e+1";
      on-scroll-down = "hyprctl dispatch workspace e-1";
      all-outputs = true;
      on-click = "activate";
    };
    battery = {
      "states" = {
        # "good" = 95;
        warning = 30;
        critical = 15;
      };
      format = "{capacity}% {icon}";
      format-full = "{capacity}% {icon}";
      format-charging = "{capacity}% ";
      format-plugged = "{capacity}% ";
      format-alt = "{time} {icon}";
      # "format-good" = "", // An empty format will hide the module
      # "format-full": "",
      format-icons = [" " " " " " " " " "];
    };
    cpu = {
      interval = 10;
      format = "󰻠 {}%";
      max-length = 10;
      on-click = "";
    };
    memory = {
      interval = 30;
      format = "  {}%";
      format-alt = " {used:0.1f}G";
      max-length = 10;
    };
    backlight = {
      format = "󰖨  {}";
      device = "acpi_video0";
    };
    # "custom/weather" = {
    #   tooltip = true;
    #   format = "{}";
    #   restart-interval = 300;
    #   exec = "/home/roastbeefer/.cargo/bin/weather";
    # };
    tray = {
      icon-size = 13;
      tooltip = false;
    };
    network = {
        interface = "wlp2s0";
        format = "{ifname}";
        format-wifi = "{essid} ({signalStrength}%) ";
        format-ethernet = "{ipaddr}/{cidr} 󰊗";
        format-disconnected = "disconnected";
        tooltip-format = "{ifname} via {gwaddr} 󰊗";
        tooltip-format-wifi = "{essid} ({signalStrength}%) ";
        tooltip-format-ethernet = "{ifname} ";
        tooltip-format-disconnected = "Disconnected";
        max-length = 50;
    };
    clock = {
      format = "  {:%I:%M %p    %m/%d} ";
      tooltip-format = ''
        <big>{:%Y %B}</big>
        <tt><small>{calendar}</small></tt>'';
    };
    pulseaudio = {
      format = "{icon} {volume}%";
      tooltip = false;
      format-muted = " Muted";
      on-click = "pamixer -t";
      on-scroll-up = "pamixer -i 5";
      on-scroll-down = "pamixer -d 5";
      scroll-step = 5;
      format-icons = {
        headphone = "";
        hands-free = "";
        headset = "";
        phone = "";
        portable = "";
        car = "";
        default = [ "" "" "" ];
      };
    };
    "pulseaudio/slider" = {
      min = 0;
      max = 100;
      orientation = "horizontal";
    };
    "pulseaudio#microphone" = {
      format = "{format_source}";
      tooltip = false;
      format-source = " {volume}%";
      format-source-muted = " Muted";
      on-click = "pamixer --default-source -t";
      on-scroll-up = "pamixer --default-source -i 5";
      on-scroll-down = "pamixer --default-source -d 5";
      scroll-step = 5;
    };
    "custom/divider" = {
      format = "|";
      interval = "once";
      tooltip = false;
    };
    "custom/endright" = {
      format = "_";
      interval = "once";
      tooltip = false;
    };
    "custom/file-manager" = {
      format = "   ";
      "on-click" = "dolphin";
      "tooltip" = true; 
      "tooltip-format" = "File Manager"; 
    };
    "custom/media" = {
      "format" = "{icon} {text}";
      "return-type" = "json";
      "max-length" = 40;
      "format-icons" = {
        "spotify" = "";
        "default" = "🎜";
      };
      "escape" = true;
      "exec" = "${./mediaplayer.py} 2> /dev/null"; # Script in resources folder
      # "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" # Filter player based on name
    };
    "custom/power" = {
      "format" = "⏻  ";
      "tooltip"= false;
      "menu" = "on-click";
      "menu-file" = "${./power_menu.xml}"; # Menu file in resources folder
      "menu-actions" = {
        "shutdown" = "hyprshutdown --post-cmd 'poweroff'";
        "reboot" = "hyprshutdown --post-cmd 'reboot'";
        "suspend" = "systemctl suspend";
        "hibernate" = "systemctl hibernate";
      };
    };
  }];
}


