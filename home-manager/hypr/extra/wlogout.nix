{ pkgs, ... }:
{
  programs.wlogout.enable = true;

  # Default layout at https://github.com/ArtsyMacaw/wlogout/blob/master/layout
  programs.wlogout.layout = [
    {
      "label" = "lock";
      "action" = "hyprlock";
      "text" = "Lock";
      "keybind" = "l";
    }
    {
      "label" = "shutdown";
      # https://github.com/hyprwm/Hyprland/blob/main/example/hyprland.conf @ line 240
      "action" = "hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch exit";
      "text" = "Shutdown";
      "keybind" = "s";
    }
    {
      "label" = "reboot";
      "action" = "hyprctl reload";
      "text" = "Reload Hyprland";
      "keybind" = "h";
    }
    {
      "label" = "reboot";
      "action" = "systemctl reboot";
      "text" = "Reboot System";
      "keybind" = "r";
    }
  ];

  # Default style.css found at https://github.com/ArtsyMacaw/wlogout/blob/master/style.css
  programs.wlogout.style = let 
    icons-dir = "${pkgs.wlogout}/share/wlogout/icons";
  in ''
    * {
        background-image: none;
        box-shadow: none;
    }

    window {
        background-color: rgba(12, 12, 12, 0.9);
    }

    button {
        border-radius: 0;
        border-color: black;
        text-decoration-color: #FFFFFF;
        color: #FFFFFF;
        background-color: #1E1E1E;
        border-style: solid;
        border-width: 1px;
        background-repeat: no-repeat;
        background-position: center;
        background-size: 25%;
    }

    button:focus, button:active, button:hover {
        background-color: #3700B3;
        outline-style: none;
    }

    #lock {
        background-image: image(url("${icons-dir}/lock.png"), url("${icons-dir}/lock.png"));
    }

    #logout {
        background-image: image(url("${icons-dir}/logout.png"), url("${icons-dir}/logout.png"));
    }

    #suspend {
        background-image: image(url("${icons-dir}/suspend.png"), url("${icons-dir}/suspend.png"));
    }

    #hibernate {
        background-image: image(url("${icons-dir}/hibernate.png"), url("${icons-dir}/hibernate.png"));
    }

    #shutdown {
        background-image: image(url("${icons-dir}/shutdown.png"), url("${icons-dir}/shutdown.png"));
    }

    #reboot {
        background-image: image(url("${icons-dir}/reboot.png"), url("${icons-dir}/reboot.png"));
    }
  '';
}
