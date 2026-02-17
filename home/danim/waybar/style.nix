{ config, lib, ... }:
{
  stylix.targets.waybar = {
    # enable = true;
    # addCss = true;
    # opacity.override.desktop = 0.80; # override background opacity
  };

  programs.waybar.style = with config.stylix.base16Scheme; lib.mkAfter ''
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
      border-width: 1px;
      border-radius: 12px;
    }

    tooltip label {
      padding: 6px;
    }

    #workspaces {
      padding: 5px 3px;
      margin: 0 0 0 12px;
      border-radius: 18px;
      border-width: 1px;
      background: ${base00};
    }

    #workspaces button {
      padding: 0px 6px;
      margin: 0px 3px;
      border-radius: 50px;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button.active {
      min-width: 50px;
      transition: all 0.3s ease-in-out;
    }

    #workspaces button.hover {
      border-radius: 8px;
      min-width: 50px;
      background-size: 400% 400%;
    }

    #workspaces button.urgent {
      border-radius: 8px;
      min-width: 50px;
      background-size: 400% 400%;
      transition: all 0.3s ease-in-out;
    }

    .modules-right {
      padding: 5px 3px;
      margin: 0 0 0 5px;
      border-radius: 18px;
      border-width: 1px;
      background: ${base00};
    }

    .modules-center {
      padding: 5px 3px;
      border-radius: 18px;
      border-width: 1px;
      background: ${base00};
    }

    #battery,
    #backlight,
    #pulseaudio,
    #network,
    #clock,
    #custom-notifications {
      margin: 0 6px 0 0;
      padding: 0 15px;
      border-radius: 50px;
      border-width: 1px;
    }

    #battery:hover,
    #backlight:hover,
    #pulseaudio:hover,
    #network:hover,
    #clock:hover,
    #custom-notifications:hover {
      background: ${base05};
      color: ${base01};
      transition: all 0.3s ease-in-out;
    }

    #group-power {
      padding: 0 15px;
      margin: 0 6px 0 0;
      border-radius: 50px;
    }

    #custom-power {
      margin-right: 6px;
    }

    .not-power {
      margin-left: 6px;
    }

    .not-power > * {
      margin: 0 6px;
    }
  '';
}
