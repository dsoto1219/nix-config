{ config, lib, ... }:
{
  stylix.targets.waybar = {
    # enable = true;
    # addCss = true;
    opacity.override.desktop = 0.95; # override background opacity
  };

  programs.waybar.style = with config.lib.stylix.colors; (lib.mkAfter ''
    #workspaces {
      /* padding: 5px 3px; */
      margin: 8px;
      border-radius: 12px;
      border: 1px solid #${base01};
      /* background: #${base01}; */
    }

    #workspaces button:hover {
      min-width: 50px;
      transition: all 0.3s ease-in-out;
    }

    #tray {
      padding: 5px 12px;
      margin: 15px 6px;
      border-radius: 36px;
      border-width: 1px;
      background: #${base0D};
      min-width: 32px;
    }

    .modules-right {
      padding: 5px 6px;
      margin: 8px;
      border-radius: 36px;
      border-width: 1px;
      background: #${base01};
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
      color: #${base0A};
    }

    #clock {
      color: #${base0E};
    }

    #battery.good {
      color: #${base0C};
    }

    #battery.warning {
      color: #${base0A};
    }

    #battery.critical {
      color: #${base0F};
    }

    #battery:hover,
    #backlight:hover,
    #pulseaudio:hover,
    #network:hover,
    #clock:hover,
    #custom-notifications:hover {
      color: #${base01};
      background-color: #${base05};
      transition: all 0.3s ease-in-out;
    }

    #pulseaudio:hover {
      background-color: #${base0A};
    }

    #clock:hover {
      background-color: #${base0E};
    }

    #battery:hover {
      background-color: #${base0F};
    }

    .modules-center {
      padding: 5px 10px;
      margin: 8px;
      border-radius: 36px;
      border-width: 1px;
      background: #${base01};
    }

    #custom-power,
    #custom-search,
    #custom-file-manager {
      padding: 0 6px;
      margin: 0 3px;
    }
  '');
}
