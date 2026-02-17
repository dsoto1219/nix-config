{ config, lib, ... }:
{
  stylix.targets.waybar = {
    # enable = true;
    # addCss = true;
    opacity.override.desktop = 0.95; # override background opacity
  };

  programs.waybar.style = with config.lib.stylix.colors; (lib.mkAfter ''
    * {
      border: none;
      /* border-radius: 0px; */

      /* min-height: 0; */
      padding: 0;
      margin: 0;
    }

    window#waybar {
      background-color: transparent;
    }

    tooltip {
      background: #${base00};
      border: 1px solid #${base03};
      border-radius: 12px;
    }

    tooltip label {
      padding: 6px;
    }

    #workspaces {
      padding: 5px 3px;
      margin: 8px;
      border-radius: 36px;
      border-width: 1px;
      background: #${base01};
    }

    #workspaces button {
      padding: 3px 12px;
      margin: 0px 3px;
      border-radius: 50px;
      transition: all 0.3s ease-in-out;
    }

    /* Let stylix handle this
    #workspaces button.active {
      min-width: 50px;
      transition: all 0.3s ease-in-out;
      background-color: #${base0C};
      color: #${base00};
    }

    #workspaces button:hover {
      background-color: #${base0B};
      color: #${base00};
      border-radius: 8px;
      min-width: 50px;
      background-size: 400% 400%;
    }
    */

    #workspaces button.urgent {
      border-radius: 8px;
      min-width: 50px;
      background-size: 400% 400%;
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
      background: #${base00};
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
      color: #${base0A};
    }

    #backlight {
      background-color: #${base0B};
    }

    #clock {
      color: #${base0E};
    }

    #battery {
      color: #${base0F};
    }

    #battery:hover,
    #backlight:hover,
    #pulseaudio:hover,
    #network:hover,
    #clock:hover,
    #custom-notifications:hover {
      background: #${base05};
      color: #${base01};
      transition: all 0.3s ease-in-out;
    }

    .modules-center {
      padding: 5px 10px;
      margin: 8px;
      border-radius: 36px;
      border-width: 1px;
      background: #${base00};
    }

    #group-power {
      padding: 0 6px;
      margin: 0 3px;
      border-radius: 50px;
    }

    .not-power > * {
      margin: 0 6px;
    }

    #custom-search {
      padding: 0 6px;
      margin: 0 3px;
    }

    #custom-file-manager {
      padding: 0 6px;
      margin: 0 3px;
    }
  '');
}
