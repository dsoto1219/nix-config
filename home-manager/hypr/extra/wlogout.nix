{ ... }:
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
  programs.wlogout.style = ''
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
        background-image: image(url("/usr/share/wlogout/icons/lock.png"), url("/usr/local/share/wlogout/icons/lock.png"));
    }

    #logout {
        background-image: image(url("/usr/share/wlogout/icons/logout.png"), url("/usr/local/share/wlogout/icons/logout.png"));
    }

    #suspend {
        background-image: image(url("/usr/share/wlogout/icons/suspend.png"), url("/usr/local/share/wlogout/icons/suspend.png"));
    }

    #hibernate {
        background-image: image(url("/usr/share/wlogout/icons/hibernate.png"), url("/usr/local/share/wlogout/icons/hibernate.png"));
    }

    #shutdown {
        background-image: image(url("/usr/share/wlogout/icons/shutdown.png"), url("/usr/local/share/wlogout/icons/shutdown.png"));
    }

    #reboot {
        background-image: image(url("/usr/share/wlogout/icons/reboot.png"), url("/usr/local/share/wlogout/icons/reboot.png"));
    }
  '';
}
