{ ... }: let 
  lua = lib.generators.mkLuaInLine;
  bind = key: action: { 
    _args = [ 
      key 
      (lua action) 
    ]; 
  };
  bindo = key: action: opts: { 
    _args = [ 
      key 
      (lua action) 
      (lua opts) 
    ]; 
  };
  exec = cmd: ''hl.dsp.exec_cmd("${cmd}")'';
  ws   = n:   ''hl.dsp.focus({ workspace = "${n}" })'';
  mvws = n:   ''hl.dsp.window.move({ workspace = "${n}" })'';
in {
  wayland.windowManager.hyprland.settings = {

    # Set programs that you use
    terminal    = { _var = "kitty"; };
    fileManager = { _var = "dolphin"; };
    menu        = { _var = "hyprlauncher"; };

    ###################
    ### KEYBINDINGS ###
    ###################

    mainMod = { _var = "SUPER"; }; # Sets "Windows" key as main modifier 
    shiftMod = { _var = "SUPER shift"; }; 

    bind = [
      # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
      (bind "mainMod .. Q" (exec "terminal"))
      (bind "mainMod .. C" (lua "hl.dsp.window.close()"))
      (bind "mainMod .. E" (exec "fileManager"))
      (bind "mainMod .. V" (lua "hl.dsp.window.float({ action = \"toggle\"})"))
      (bind "mainMod .. R" (exec "menu"))
      (bind "mainMod .. P" (lua "hl.dsp.window.psuedo()"))
      (bind "mainMod .. J" (lua "hl.dsp.layout(\"togglesplit\")")) # dwindle only

      # Move focus with mainMod + vim direction keys
      (bind "mainMod .. H" (lua "hl.dsp.focus({ direction = \"left\"})"))
      (bind "mainMod .. L" (lua "hl.dsp.focus({ direction = \"right\"})"))
      (bind "mainMod .. K" (lua "hl.dsp.focus({ direction = \"up\"})"))
      (bind "mainMod .. J" (lua "hl.dsp.focus({ direction = \"down\"})"))

      # Switch workspaces with mainMod + [0-9]
      (bind "mainMod + 1" (ws "1"))
      (bind "mainMod + 2" (ws "2"))
      (bind "mainMod + 3" (ws "3"))
      (bind "mainMod + 4" (ws "4"))
      (bind "mainMod + 5" (ws "5"))
      (bind "mainMod + 6" (ws "6"))
      (bind "mainMod + 7" (ws "7"))
      (bind "mainMod + 8" (ws "8"))
      (bind "mainMod + 9" (ws "9"))
      (bind "mainMod + 0" (ws "10"))
      # Move through existing workspaces with tab
      (bind "mainMod + Tab" ''hl.dsp.focus({ workspace = "e+1" })'')

      # Move window to workspace
      (bind "mainMod + SHIFT + 1" (mvws "1"))
      (bind "mainMod + SHIFT + 2" (mvws "2"))
      (bind "mainMod + SHIFT + 3" (mvws "3"))
      (bind "mainMod + SHIFT + 4" (mvws "4"))
      (bind "mainMod + SHIFT + 5" (mvws "5"))
      (bind "mainMod + SHIFT + 6" (mvws "6"))
      (bind "mainMod + SHIFT + 7" (mvws "7"))
      (bind "mainMod + SHIFT + 8" (mvws "8"))
      (bind "mainMod + SHIFT + 9" (mvws "9"))
      (bind "mainMod + SHIFT + 0" (mvws "10"))

      # Example special workspace (scratchpad)
      (bind "mainMod + S" (lua "hl.dsp.workspace.toggle_special(\"magic\")"))
      (bind "mainMod + SHIFT + S" (lua "hl.dsp.window.move({ workspace = \"special:magic\" })"))

      # Scroll through existing workspaces with mainMod + scroll
      (bind "mainMod + mouse_down" (lua ''hl.dsp.focus({ workspace = "e-1" })''))
      (bind "mainMod + mouse_up" (lua ''hl.dsp.focus({ workspace = "e-1" })''))

      # Move/resize windows with mainMod + LMB/RMB and dragging
      (bind "mainMod + mouse:272" (lua ''hl.dsp.window.drag(),   { mouse = true }''))
      (bind "mainMod + mouse:273" (lua ''hl.dsp.window.resize(), { mouse = true }''))

      # Laptop multimedia keys for volume and LCD brightness
      (bindo "XF86AudioRaiseVolume"
        (exec "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+")
        ''{ locked = true, repeating = true }'')
      (bindo "XF86AudioLowerVolume" 
        (exec "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-")
        ''{ locked = true, repeating = true }'')
      (bindo "XF86AudioMute" 
        (exec "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")
        ''{ locked = true, repeating = true }'')
      (bindo "XF86AudioMicMute" 
        (exec "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") 
        ''{ locked = true, repeating = true }'')
      (bindo "XF86MonBrightnessUp"
        (exec "brightnessctl -e4 -n2 set 5%+") 
        ''{ locked = true, repeating = true }'')
      (bindo "XF86MonBrightnessDown"
        (exec "brightnessctl -e4 -n2 set 5%-") 
        ''{ locked = true, repeating = true }'')

      # # Requires playerctl
      (bindo "XF86AudioNext" 
        (exec "playerctl next") 
        ''{ locked = true }'')
      (bindo "XF86AudioPause" 
        (exec "playerctl play-pause") 
        ''{ locked = true }'')
      (bindo "XF86AudioPlay" 
        (exec "playerctl play-pause") 
        ''{ locked = true }'')
      (bindo "XF86AudioPrev" 
        (exec "playerctl previous") 
        ''{ locked = true }'')

      # Custom
      (bind "$mainMod + F" "fullscreen")
      (bind "$mainMod + W" (exec "pkill waybar && waybar"))
      (bind "$mainMod + D" (exec "pkill hyprpicker || hyprpicker --autocopy"))
      # Bind power key: https://github.com/hyprwm/Hyprland/issues/2614#issuecomment-2395597405
      (bind "XF86PowerOff" (exec "hyprshutdown --post-cmd 'poweroff'"))
      # "$mainMod, U, layoutmsg, togglesplit # dwindle" ???

      # hyprshot
      # Screenshot a window with SUPER + PrintScr
      (bindo "PRINT" 
        (exec "hyprshot -m output --clipboard-only")
        ''{ locked = true }'')
      (bindo "SHIFT + PRINT" 
        (exec "hyprshot -m region --clipboard-only") 
        ''{ locked = true }'')
    ];
  };
}
