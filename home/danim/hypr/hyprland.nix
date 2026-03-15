{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    # Split settings
    ./keybinds.nix

    # Related config files
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpanel.nix
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
  programs.hyprshot.enable = true; # screenshot manager

  # Hyprland Configuration
  wayland.windowManager.hyprland = {
    enable = true;

    # Docs say to do this since we're using home manager
    # as a nixos module
    package = null; 
    portalPackage = null; 

    settings = {
      ################
      ### MONITORS ###
      ################

      # See https://wiki.hypr.land/Configuring/Monitors/
      monitor = [
        ",preferred,auto,auto"
      ];

      ###################
      ### MY PROGRAMS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Keywords/
      # Set programs that you use
      "$terminal" = "kitty";
      "$fileManager" = "dolphin";
      "$menuProgram" = "rofi";
      "$menuCommand" = "rofi -show drun";

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:
      exec-once = [
        "systemctl --user start hyprpolkitagent"
        "hyprlock || hyprctl dispatch exit"
        # "$terminal"
        "hyprpaper"
        "waybar"
        "swaync"
        "nm-applet &"
        "hypridle"
        "udiskie"
        # https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
        "systemd-inhibit --who=\"Hyprland config\" --why=\"Hyprland power key keybind\" --what=handle-power-key --mode=block sleep infinity & echo $! > /tmp/.hyprland-systemd-inhibit"
      ];
      exec-shutdown = [
        "kill -9 \"$(cat /tmp/.hyprland-systemd-inhibit)\""
      ];

      #############################
      ### ENVIRONMENT VARIABLES ###
      #############################

      # See https://wiki.hypr.land/Configuring/Environment-variables/
      # env = let 
      #   cursor_size = "24";
      # in [
      #   "XCURSOR_SIZE,${cursor_size}"
      #   "HYPRCURSOR_SIZE,${cursor_size}"
      # ];

      ###################
      ### PERMISSIONS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Permissions/
      # Please note permission changes here require a Hyprland restart and are not applied on-the-fly for security reasons
      # ecosystem = {
      #   enforce_permissions = 1
      # }
      # permission = [
      #   "/usr/(bin|local/bin)/grim, screencopy, allow"  
      #   "/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland, screencopy, allow"
      #   "/usr/(bin|local/bin)/hyprpm, plugin, allow"
      # ];
      # https://wiki.hypr.land/Configuring/Variables/#general

      #####################
      ### LOOK AND FEEL ###
      #####################

      # Refer to https://wiki.hypr.land/Configuring/Variables/
      general = {
        gaps_in = 5;
        gaps_out = 20;

        border_size = 2;

        # https://wiki.hypr.land/Configuring/Variables/#variable-types for info about colors
        "col.active_border" = lib.mkDefault "rgba(33ccffee) rgba(00ff99ee) 45deg";
        "col.inactive_border" = lib.mkDefault "rgba(595959aa)";

        # Set to true enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = true;

        # Please see https://wiki.hypr.land/Configuring/Tearing/ before you turn this on
        allow_tearing = false;

        layout = "dwindle";
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
          color = lib.mkDefault "rgba(1a1a1aee)";
        };

          # https://wiki.hypr.land/Configuring/Variables/#blur
        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      # https://wiki.hypr.land/Configuring/Variables/#animations
      animations = {
        enabled = "yes, please :)";

        # Default curves, see https://wiki.hypr.land/Configuring/Animations/#curves
        bezier = [ 
          # NAME,          X0,   Y0,   X1,   Y1
          "easeOutQuint,   0.23, 1,    0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear,         0,    0,    1,    1"
          "almostLinear,   0.5,  0.5,  0.75, 1"
          "quick,          0.15, 0,    0.1,  1"
        ];

          # Default animations, see https://wiki.hypr.land/Configuring/Animations/
        animation = [
          # NAME,         ONOFF, SPEED, CURVE,        [STYLE]
          "global,        1,     10,    default"
          "border,        1,     5.39,  easeOutQuint"
          "windows,       1,     4.79,  easeOutQuint"
          "windowsIn,     1,     4.1,   easeOutQuint, popin 87%"
          "windowsOut,    1,     1.49,  linear,       popin 87%"
          "fadeIn,	      1,     1.73,  almostLinear"
          "fadeOut,       1,     1.46,  almostLinear"
          "fade,          1,     3.03,  quick"
          "layers,        1,     3.81,  easeOutQuint"
          "layersIn,      1,     4,     easeOutQuint, fade"
          "layersOut,     1,     1.5,   linear,       fade"
          "fadeLayersIn,  1,     1.79,  almostLinear"
          "fadeLayersOut, 1,     1.39,  almostLinear"
          "workspaces,    1,     1.94,  almostLinear, fade"
          "workspacesIn,  1,     1.21,  almostLinear, fade"
          "workspacesOut, 1,     1.94,  almostLinear, fade"
          "zoomFactor,    1,     7,     quick"
        ];
      };

      # Ref https://wiki.hypr.land/Configuring/Workspace-Rules/
      # "Smart gaps" / "No gaps when only"
      # uncomment all if you wish to use that.
      workspace = [
        # "w[tv1], gapsout:0, gapsin:0"
        # "f[1], gapsout:0, gapsin:0"

        # Persistent workspaces
        "1, monitor:eDP-1, persistent:true"
        "2, monitor:eDP-1, persistent:true"
        "3, monitor:eDP-1, persistent:true"
      ];

      # See https://wiki.hypr.land/Configuring/Dwindle-Layout/ for more
      dwindle = {
        pseudotile = true; # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
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
        };
      };

      # See https://wiki.hypr.land/Configuring/Gestures
      gesture = [
        "3, horizontal, workspace"
      ];
      # Example per-device config
      # See https://wiki.hypr.land/Configuring/Keywords/#per-device-input-configs for more
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
          "match:class" = ".*";

          suppress_event = "maximize";
        }

        # Fix some dragging issues with XWayland
        {
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;

          no_focus = true;
        }

        # Hyprland-run windowrule
        {
          name = "move-hyprland-run";

          "match:class" = "hyprland-run";

          move = "20 monitor_h-120";
          float = "yes";
        }

        # {
        #   name = "no-gaps-wtv1";
        #   "match:float" = false;
        #   "match:workspace" = "w[tv1]";
        #
        #   border_size = 0;
        #   rounding = 0;
        # }
        #
        # {
        #   name = "no-gaps-f1";
        #   "match:float" = false;
        #   "match:workspace" = "f[1]";
        #
        #   border_size = 0;
        #   rounding = 0;
        # }
      ];
    };
  };

  # Cursor settings #
  # home.pointerCursor = {
  #   gtk.enable = true;
  #   # x11.enable = true;
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  # };
  #
  # gtk = {
  #   enable = true;
  #   theme = {
  #     package = pkgs.flat-remix-gtk;
  #     name = "Flat-Remix-GTK-Grey-Darkest";
  #   };
  #
  #   iconTheme = {
  #     package = pkgs.gnome.adwaita-icon-theme;
  #     name = "Adwaita";
  #   };
  #
  #   font = {
  #     name = "Sans";
  #     size = 11;
  #   };
  # };
}
