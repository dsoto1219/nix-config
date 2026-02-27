{ config, lib, ... }:
{
  stylix.targets.waybar = {
    # enable = true;
    # addCss = true;
    opacity.override.desktop = 0.95; # override background opacity
  };

  programs.waybar.style = lib.mkAfter ''
    #workspaces {
        /* padding: 5px 3px; */
        margin: 4px;
        border-radius: 12px;
        border: 1px solid @base01;
        /* background: @base01; */
    }

    #workspaces button:hover {
        min-width: 40px;
        transition: all 0.3s ease-in-out;
    }

    #workspaces button:not(:hover) {
        transition: all 0.3s ease-in-out;
    }

    #tray {
        padding: 5px 12px;
        margin: 15px 6px;
        border-radius: 36px;
        border-width: 1px;
        background: @base0D;
        min-width: 32px;
    }

    .modules-center {
        padding: 5px 10px;
        margin: 8px;
        border-radius: 36px;
        border-width: 1px;
        background: @base01;
    }

    #custom-power,
    #custom-search,
    #custom-file-manager {
        padding: 0 6px;
        margin: 0 3px;
    }

    .modules-right {
        padding: 5px 6px;
        margin: 8px;
        border-radius: 36px;
        border-width: 1px;
        background: @base01;
    }

    #battery,
    #backlight,
    #pulseaudio,
    #network,
    #clock,
    #custom-notifications {
        margin: 0 3px;
        padding: 10px 15px;
        border-radius: 50px;
        border-width: 1px;
    }

    #pulseaudio {
        min-width: 30px;
        color: @base0B;
    }

    #backlight {
        color: @base06;
    }

    #battery.warning {
      color: @base0A;
    }

    #battery.critical {
      color: @base0F;
    }

    #battery.charging {
      color: @base0C;
    }

    #clock {
        color: @base0E;
    }

    #custom-notifications {
        color: @base04;
    }

    #battery:hover,
    #backlight:hover,
    #pulseaudio:hover,
    #network:hover,
    #clock:hover,
    #custom-notifications:hover {
        color: @base01;
        background-color: @base05;
        transition: all 0.3s ease-in-out;
    }

    #pulseaudio:hover {
        background-color: @base0B;
    }

    #backlight:hover {
        background-color: @base06;
    }

    #clock:hover {
        background-color: @base0E;
    }

    #battery.warning:hover {
      background-color: @base0A;
    }

    #battery.critical:hover {
      background-color: @base0F;
    }

    #battery.charging:hover {
      background-color: @base0C;
    }
  '';
}
