{ ... }:
{
  wayland.windowManager.hyprland.settings = {
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
      "$mainMod, R, exec, killall $menuProgram || $menuCommand"
      "$mainMod, P, pseudo, # dwindle"
      "$shiftMod, J, layoutmsg, togglesplit # dwindle"

      # Custom
      "$mod, F, fullscreen"
      "$mod, L, exec, hyprctl reload"
      "$mod, W, exec, pkill waybar && waybar"
      "$mod, D, exec, pkill hyprpicker || hyprpicker --autocopy"
      # Bind power key: https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
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
  };
}
