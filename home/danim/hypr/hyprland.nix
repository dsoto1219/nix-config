{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    # Split settings
    ./keybinds.nix

    # Related config files
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
  ];

  home.packages = with pkgs; [
    unstable.hyprshutdown
    mpd
    hyprpicker
    brightnessctl
    kdePackages.dolphin # file manager
    wl-clipboard
    udiskie
  ];

  programs.kitty.enable = true;
  services.swaync.enable = true; # notification manager
  programs.hyprshot = {
    enable = true; # screenshot manager
    saveLocation = "$HOME/Pictures/Screenshots";
  };

  # Hyprland Configuration
  wayland.windowManager.hyprland = {
    enable = true;

    # Docs say to do this since we're using home manager
    # as a nixos module
    package = null; 
    portalPackage = null; 

    systemd.variables = [ "--all" ];

    settings = let
      terminal = "kitty";
    in {
      ################
      ### MONITORS ###
      ################

      # See https://wiki.hypr.land/configuring/core/monitors/
      monitor = {
        output   = "";
        mode     = "preferred";
        position = "auto";
        scale    = "auto";
      };

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:
      on = [
        {
          _args = [
            "hyprland.start"
            (lib.generators.mkLuaInLine ''
              function()
                hl.exec_cmd("systemctl --user start hyprpolkitagent")
                hl.exec_cmd("hyprlock || hyprctl dispatch exit")
                hl.exec_cmd("waybar & hyprpaper & swaync")
                hl.exec_cmd("nm-applet &")
                hl.exec_cmd("blueman-applet &")
                hl.exec_cmd("hypridle")
                hl.exec_cmd("udiskie")
                -- https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
                hl.exec_cmd("systemd-inhibit --who=\"Hyprland config\" --why=\"Hyprland power key keybind\" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit")
              end
            '')
          ];
        }
        {
          _args = [
            "hyprland.shutdown"
            (lib.generators.mkLuaInLine ''
              function()
                hl.exec_cmd("kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)\"")
              end
            '')
          ];
        }
      ];

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hypr.land/Configuring/Environment-variables/
      env = let
        cursor_size = 32;
      in [
        {
          _args = [
            "XCURSOR_SIZE"
            "${cursor_size}"
          ];
        }
        {
          _args = [
            "HYPRCURSOR_SIZE"
            "${cursor_size}"
          ];
        }
      ];

      ###################
      ### PERMISSIONS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Permissions/
      # Please note permission changes here require a Hyprland restart and are not applied on-the-fly for security reasons
      # -- hl.config({
      # --   ecosystem = {
      # --     enforce_permissions = true,
      # --   },
      # -- })
      #
      # -- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
      # -- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
      # -- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hypr.land/Configuring/Variables/
      config = {
        general = {
          gaps_in = 5;
          gaps_out = 20;

          border_size = 2;

          col = {
            active_border = { 
              colors = [
                "rgba(33ccffee)" 
                "rgba(00ff99ee)"
              ];
              angle = 45;
            };
            inactive_border = "rgba(595959aa)";
          };

          # Set to true enable resizing windows by clicking and dragging on borders and gaps
          resize_on_border = true;

          # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
          allow_tearing = false;

          layout = "dwindle";
        };
      };

      # https://wiki.hypr.land/Configuring/Variables/#decoration
      decoration = {
        rounding = 10;
        rounding_power = 2;

        # Change transparency of focused and unfocused windows
        active_opacity = 1.0;
        inactive_opacity = 1.0;

        shadow = {
          enabled = true;
          range = 4;
          render_power = 3;
          color = "0xee1a1a1a";
        };

          # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };

        animations = {
          enabled = true;
        };

        # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
        dwindle = {
          # pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below [OPTION BROKEN]
          preserve_split = true; # You probably want this
        };

        # See https://wiki.hypr.land/Configuring/Master-Layout/ for more
        master = {
          new_status = "master";
        };

        # https://wiki.hypr.land/Configuring/Variables/#misc
        misc = {
          # force_default_wallpaper = 2; # Set to 0 or 1 to disable the anime mascot wallpapers
          # disable_hyprland_logo = false; # If true disables the random hyprland logo / anime girl background. :(
        };

        #############
        ### INPUT ###
        #############

        # https://wiki.hypr.land/Configuring/Variables/#input
        input = {
          kb_layout = "us";
          # kb_variant =
          # kb_model =
          # kb_options =
          # kb_rules =

          follow_mouse = 1;

          sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

          touchpad = {
            natural_scroll = true;
            disable_while_typing = false;
          };
        };

        xwayland = {
          force_zero_scaling = true;
          use_nearest_neighbor = true;
        };
      };

      # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
      curve = [
        {
          _args = [
            "easeOutQuint"
            { 
              type = "bezier"; 
              points = [
                [0.23 1]
                [0.32 1]
              ];
            }
          ];
        }
        {
          _args = [
            "easeInOutCubic"
            { 
              type = "bezier";
              points = [
                [0.65 0.05]
                [0.36 1]
              ];
            }
          ];
        }
        {
          _args = [
            "linear"
            { 
              type = "bezier";
              points = [
                [0 0]
                [1 1]
              ];
            }
          ];
        }
        {
          _args = [
            "almostLinear"
            { 
              type = "bezier";
              points = [
                [0.5  0.5]
                [0.75 1]
              ];
            }
          ];
        }
        {
          _args = [
            "quick"
            { 
              type = "bezier";
              points = [
                [0.15  0]
                [0.1   1]
              ];
            }
          ];
        }

        # Default springs
        {
          _args = [
            "easy"
            {
              type = "spring";
              mass = 1;
              stiffness = 238.1191;
              damping = 24.21279333;
            }
          ];
        }
      ];

      animation = [
        {
          leaf = "global";
          enabled = true;
          speed = 10;
          bezier = "default";
        }
        {
          leaf = "border";
          enabled = true;
          speed = 5.39; 
          bezier = "easeOutQuint"; 
        }
        {
          leaf = "windows";
          enabled = true;
          speed = 4.79; 
          spring = "easy";
        }
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 4.1;
          spring = "easy";
          style = "popin 87%";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 1.49; 
          bezier = "linear";
          style = "popin 87%";
        }
        {
          leaf = "fadeIn";
          enabled = true;  
          speed = 1.73; 
          bezier = "almostLinear"; 
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 1.46;
          bezier = "almostLinear";
        }
        {
          leaf = "fade";
          enabled = true;
          speed = 3.03;
          bezier = "quick";
        }
        {
          leaf = "layers";
          enabled = true;
          speed = 3.81;
          bezier = "easeOutQuint";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 4;
          bezier = "easeOutQuint";
          style = "fade"; 
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 1.5;
          bezier = "linear";
          style = "fade";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 1.79;
          bezier = "almostLinear";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 1.39;
          bezier = "almostLinear";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesIn";
          enabled = true;
          speed = 1.21;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "workspacesOut";
          enabled = true;
          speed = 1.94;
          bezier = "almostLinear";
          style = "fade";
        }
        {
          leaf = "zoomFactor";
          enabled = true;
          speed = 7;
          bezier = "quick";
        }
      ];

      # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      # workspace = [
        # "w[tv1], gapsout:0, gapsin:0"
        # "f[1], gapsout:0, gapsin:0"

        # Persistent workspaces
        # "1, monitor:eDP-1, persistent:true"
        # "2, monitor:eDP-1, persistent:true"
        # "3, monitor:eDP-1, persistent:true"
      # ];

      #####################
      ### INPUT (CONT.) ###
      #####################

      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = { 
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };

      # Example per-device config
      # See https://wiki.hypr.land/configuring/core/devices/ for more
      # device = {
      #   name = "epic-mouse-v1";
      #   sensitivity = -0.5;
      # };

      ##############################
      ### WINDOWS AND WORKSPACES ###
      ##############################

      # See https://wiki.hypr.land/Configuring/Window-Rules/ for more
      # See https://wiki.hypr.land/Configuring/Workspace-Rules/ for workspace rules

      # Example windowrules that are useful
      windowrule = [

        # Ignore maximize requests from all apps. You'll probably like this.
        {
          name = "suppress-maximize-events";
          match = { class = ".*"; };

          suppress_event = "maximize";
        }

        # Fix some dragging issues with XWayland
        {
          name = "fix-xwayland-drags";
          match = {
            class      = "^$";
            title      = "^$";
            xwayland   = true;
            float      = true;
            fullscreen = false;
            pin        = false;
          };

          no_focus = true;
        }

        # Hyprland-run windowrule
        {
          name = "move-hyprland-run";
          match = { class = "hyprland-run"; };

          move = "20 monitor_h-120";
          float = "yes";
        }
      ];
    };
  };
}
