{ lib, pkgs, ... }: 
{
  home.packages = with pkgs; [
    pavucontrol # volume controller
  ];

  programs.waybar.enable = true;

  stylix.targets.waybar = {
    # enable = true;
    # addCss = true;
    opacity.override.desktop = 0.80; # override background opacity
  };

  programs.waybar.style = lib.mkAfter (builtins.readFile ./style.css);
  
  programs.waybar.settings = [{
    # layer = "top";
    position = "top";
    # mod = "dock";
    # exclusive = true;
    # passtrough = false;
    # gtk-layer-shell = true;
    # height = 0;
    # margin-top = 15;

    modules-left = [ 
      "hyprland/workspaces" 
    ];
    modules-center = [
      "group/group-power" 
      "custom/search"
      "custom/file-manager" 
    ];
    modules-right = [
      "tray"
      "pulseaudio"
      "backlight"
      "battery"
      "clock" 
      "custom/notifications"
    ];
    "hyprland/workspaces" = {
      format = "{windows}({icon})";
      # format-window-separator = "\n";
      window-rewrite-default = "";
      window-rewrite = {
        "title<.*youtube.*>" = " "; # Windows whose titles contain "youtube"
        "class<firefox>" = " "; # Windows whose classes are "firefox"
        "class<firefox> title<.*github.*>" = " "; # Windows whose class is "firefox" and title contains "github". Note that "class" always comes first.
        "foot" = " "; # Windows that contain "foot" in either class or title. For optimization reasons, it will only match against a title if at least one other window explicitly matches against a title.
        "code" = "󰨞 ";
      };
    };
    clock = {
      format = " {:%I:%M %p} ";
      locale = "en_US.UTF-8";
      format-alt = "{:%A; %B %d, %Y (%R)}";
      tooltip-format = "<tt><small>{calendar}</small></tt>";
      calendar = {
        mode         = "year";
        mode-mon-col = 3;
        weeks-pos    = "right";
        on-scroll    = 1;
        format = {
          months   = "<span color='#ffead3'><b>{}</b></span>";
          days     = "<span color='#ecc6d9'><b>{}</b></span>";
          weeks    = "<span color='#99ffdd'><b>W{}</b></span>";
          weekdays = "<span color='#ffcc66'><b>{}</b></span>";
          today    = "<span color='#ff6699'><b><u>{}</u></b></span>";
        };
        actions =  {
          on-click-right = "mode";
          # on-scroll-up = "tz_up";
          # on-scroll-down = "tz_down";
          on-scroll-up = "shift_up";
          on-scroll-down = "shift_down";
        };
      };
    };
    "group/group-power" = {
      orientation = "inherit";
      drawer = {
        transition-duration = 500;
        children-class = "not-power";
        # transition-left-to-right = false;
      };
      modules = [
        "custom/power" # First element is the "group leader" and won't ever be hidden
        "custom/quit"
        "custom/lock"
        "custom/reboot"
      ];
    };
    "custom/quit" = {
        format = "󰗼";
        on-click = "hyprctl dispatch exit";
        tooltip-format = "Quit Hyprland";
    };
    "custom/lock" = {
        format = "󰍁";
        on-click = "hyprlock";
        tooltip-format = "Lock";
    };
    "custom/reboot" = {
        format = "󰜉";
        on-click = "hyprshutdown --post-cmd 'reboot'";
        tooltip-format = "Reboot";
    };
    "custom/power" = {
        format = "";
        on-click = "hyprshutdown --post-cmd 'poweroff'";
        tooltip-format = "Power Off";
    };
    "custom/search" = {
      format = "    ";
      on-click = "rofi -show drun";
      tooltip-format = "Search Apps";
    };
    "custom/file-manager" = {
      format = "   ";
      "on-click" = "dolphin";
      "tooltip" = true; 
      "tooltip-format" = "File Manager"; 
    };

    tray = {
      # icon-size = 21;
      spacing = 10;
      icons = {
        blueman = "bluetooth";
      };
    };

    pulseaudio = {
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}%";
      format-muted = "";
      format-icons = {
          headphone = " ";
          # hands-free = "";
          # headset = "";
          phone = " ";
          phone-muted = " ";
          portable = " ";
          car = " ";
          default = [ "" " " " " ];
      };
      scroll-step = 1;
      on-click = "pavucontrol";
      ignored-sinks = [ "Easy Effects Sink" ];
      tooltip-format = "Volume";
    };
    backlight = {
      device = "intel_backlight";
      format = "{icon} {percent}%";
      format-icons = [ "󰃚 " "󰃛 " "󰃜 " "󰃝 " "󰃞 " "󰃟 " "󰃠 " ];
      tooltip-format = "Brightness";
    };
    network = {
      interface = "wlp0s20f3";
      format = "{ifname}";
      format-wifi = "{essid}  ";
      format-ethernet = "{ipaddr}/{cidr} 󰊗 ";
      format-disconnected = ""; # An empty format will hide the module.
      tooltip-format = "{ifname} via {gwaddr} 󰊗";
      tooltip-format-wifi = "{essid} ";
      tooltip-format-ethernet = "{ifname} ";
      tooltip-format-disconnected = "Disconnected";
      max-length = 50;
    };

    battery = {
      interval = 60;
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-icons = {
        default  = ["󰂎"  "󰁺"  "󰁻"  "󰁼"  "󰁽"  "󰁾"  "󰁿"  "󰂀"  "󰂁"  "󰂂"  "󰁹"];
        charging = ["󰢟 " "󰢜 " "󰂆 " "󰂇 " "󰂈 " "󰢝 " "󰂉 " "󰢞 " "󰂊 " "󰂋 " "󰂅 "];
      };
      max-length = 25;
    };

    "custom/notifications" = {
      tooltip = true;
      format = " {icon}";
      format-icons = {
        notification = "󱅫";
        none = "󰂜";
        dnd-notification = "󰂠";
        dnd-none = "󰪓";
        inhibited-notification = "󰂛";
        inhibited-none = "󰪑";
        dnd-inhibited-notification = "󰂛";
        dnd-inhibited-none = "󰪑";
      };
      return-type = "json";
      exec-if = "which swaync-client";
      exec = "swaync-client -swb";
      on-click = "swaync-client -t -sw";
      on-click-right = "swaync-client -d -sw";
      escape = true;
      tooltip-format = "Notifications";
    };
  #   cpu = {
  #     interval = 10;
  #     format = "󰻠 {}%";
  #     max-length = 10;
  #     on-click = "";
  #   };
  #   memory = {
  #     interval = 30;
  #     format = "  {}%";
  #     format-alt = " {used:0.1f}G";
  #     max-length = 10;
  #   };
  #   backlight = {
  #     format = "󰖨 {}";
  #     device = "acpi_video0";
  #   };
  #   # "custom/weather" = {
  #   #   tooltip = true;
  #   #   format = "{}";
  #   #   restart-interval = 300;
  #   #   exec = "/home/roastbeefer/.cargo/bin/weather";
  #   # };
  #   "pulseaudio#microphone" = {
  #     format = "{format_source}";
  #     tooltip = false;
  #     format-source = " {volume}%";
  #     format-source-muted = " Muted";
  #     on-click = "pamixer --default-source -t";
  #     on-scroll-up = "pamixer --default-source -i 5";
  #     on-scroll-down = "pamixer --default-source -d 5";
  #     scroll-step = 5;
  #   };
  #   "custom/divider" = {
  #     format = "|";
  #     interval = "once";
  #     tooltip = false;
  #   };
  #   "custom/media" = {
  #     "format" = "{icon} {text}";
  #     "return-type" = "json";
  #     "max-length" = 40;
  #     "format-icons" = {
  #       "spotify" = "";
  #       "default" = "🎜";
  #     };
  #     "escape" = true;
  #     "exec" = "${./mediaplayer.py} 2> /dev/null"; # Script in resources folder
  #     # "exec": "$HOME/.config/waybar/mediaplayer.py --player spotify 2> /dev/null" # Filter player based on name
  #   };
  }];

}


