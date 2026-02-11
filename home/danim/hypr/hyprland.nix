{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does

    # Other config files
    ./hypridle.nix
    ./hyprlock.nix
    ./tofi.nix
  ];

  home.packages = with pkgs; [
    unstable.hyprshutdown
    hyprpicker
    brightnessctl
    kdePackages.dolphin # file manager
    wl-clipboard
    udiskie
  ];

  programs.kitty.enable = true;
  programs.hyprshot.enable = true; # screenshot manager

  # Hyprland Configuration
  wayland.windowManager.hyprland = let
    hyprland-pkgs = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
  in {
    enable = true;
    # set the flake package
    package = hyprland-pkgs.hyprland; 
    portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland; 
    systemd.variables = ["--all"];

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
      "$menu" = "tofi-drun";

      #################
      ### AUTOSTART ###
      #################

      # Autostart necessary processes (like notifications daemons, status bars, etc.)
      # Or execute your favorite apps at launch like this:
      exec-once = [
        "hyprlock || hyprctl dispatch exit"
        # "$terminal"
        "waybar & hyprpaper"
        "nm-applet &"
        "systemctl --user start hyprpolkitagent"
        "hypridle"
        "udiskie"
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

        layout = "master";
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
      # workspace = [
      #   "w[tv1], gapsout:0, gapsin:0"
      #   "f[1], gapsout:0, gapsin:0"
      # ];
      # windowrule = bordersize 0, floating:0, onworkspace:w[tv1]
      # windowrule = rounding 0, floating:0, onworkspace:w[tv1]
      # windowrule = bordersize 0, floating:0, onworkspace:f[1]
      # windowrule = rounding 0, floating:0, onworkspace:f[1]

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

      ###################
      ### KEYBINDINGS ###
      ###################

      # See https://wiki.hypr.land/Configuring/Keywords/
      "$mainMod" = "SUPER"; # Sets "Windows" key as main modifier
      "$mod" = "SUPER"; 
      "$shiftMod" = "SUPER shift"; 

      # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
      bind = [
        # Default
        "$mainMod, Q, exec, $terminal"
        "$mainMod, C, killactive"
        # "$mainMod, M, exit"
        "$mainMod, E, exec, $fileManager"
        "$mainMod, V, togglefloating"
        "$mainMod, R, exec, pkill $menu || $menu"
        "$mainMod, P, pseudo, # dwindle"
        "$shiftMod, J, togglesplit, # dwindle"

        # Custom
        "$mod, F, fullscreen"
        "$mod, L, exec, hyprctl reload"
        "$mod, D, exec, pkill hyprpicker || hyprpicker --autocopy"
        # Bind power key to logout: https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
        ", XF86PowerOff, exec, hyprshutdown --post-cmd 'poweroff'"

        # hyprshot
        # Screenshot a window with SUPER + PrintScr
        "$mod, PRINT, exec, hyprshot -m window"
        # Screenshot a monitor with PrintScr
        ", PRINT, exec, hyprshot -m output"
        # Screenshot a region with SUPER + Shift + S
        "$shiftMod, S, exec, hyprshot -m region" 

        # Move focus with mainMod + arrow keys
        "$mainMod, H, movefocus, l"
        "$mainMod, L, movefocus, r"
        "$mainMod, J, movefocus, u"
        "$mainMod, K, movefocus, d"

        # Switch workspaces with mainMod + [0-9]
        "$mainMod, 1, workspace, 1"
        "$mainMod, 2, workspace, 2"
        "$mainMod, 3, workspace, 3"
        "$mainMod, 4, workspace, 4"
        "$mainMod, 5, workspace, 5"
        "$mainMod, 6, workspace, 6"
        "$mainMod, 7, workspace, 7"
        "$mainMod, 8, workspace, 8"
        "$mainMod, 9, workspace, 9"
        "$mainMod, 0, workspace, 10"

        # Move active window to a workspace with mainMod + SHIFT + [0-9]
        "$mainMod SHIFT, 1, movetoworkspace, 1"
        "$mainMod SHIFT, 2, movetoworkspace, 2"
        "$mainMod SHIFT, 3, movetoworkspace, 3"
        "$mainMod SHIFT, 4, movetoworkspace, 4"
        "$mainMod SHIFT, 5, movetoworkspace, 5"
        "$mainMod SHIFT, 6, movetoworkspace, 6"
        "$mainMod SHIFT, 7, movetoworkspace, 7"
        "$mainMod SHIFT, 8, movetoworkspace, 8"
        "$mainMod SHIFT, 9, movetoworkspace, 9"
        "$mainMod SHIFT, 0, movetoworkspace, 10"

        # Example special workspace (scratchpad)
        "$mainMod, S, togglespecialworkspace, magic"
        "$mainMod SHIFT, S, movetoworkspace, special:magic"

        # Scroll through existing workspaces with mainMod + scroll
        "$mainMod, mouse_down, workspace, e+1"
        "$mainMod, mouse_up, workspace, e-1"
      ];

      # Move/resize windows with mainMod + LMB/RMB and dragging
      bindm = [
        "$mainMod, mouse:272, movewindow"
        "$mainMod, mouse:273, resizewindow"
      ];

      # Laptop multimedia keys for volume and LCD brightness
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl -e4 -n2 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl -e4 -n2 set 5%-"
      ];

      # Requires playerctl
      bindl = [
        ", XF86AudioNext, exec, playerctl next"    
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];
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
      ];
    };
  };

  # Cursor settings #
  home.pointerCursor = {
    gtk.enable = true;
    # x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 16;
  };

  gtk = {
    enable = true;
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
  };
}
