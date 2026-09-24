{ lib, ... }: let 
  lua = lib.generators.mkLuaInline;
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
  execVar = cmd: ''hl.dsp.exec_cmd(${cmd})'';
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

    bind = let 
      mod = key: lua ''mainMod .. " + ${key}"'';
    in [
      # Example binds, see https://wiki.hypr.land/Configuring/Binds/ for more
      (bind (mod "Q") (execVar "terminal"))
      (bind (mod "C") "hl.dsp.window.close()")
      (bind (mod "E") (execVar "fileManager"))
      (bind (mod "V") ''hl.dsp.window.float({ action = "toggle"})'')
      (bind (mod "R") (execVar "menu"))
      (bind (mod "P") ("hl.dsp.window.psuedo()"))
      (bind (mod "SHIFT + J") ''hl.dsp.layout("togglesplit")'') # dwindle only

      # Move focus with mainMod + vim direction keys
      (bind (mod "H") ''hl.dsp.focus({ direction = "left" }))''
      (bind (mod "L") ''hl.dsp.focus({ direction = "right" })'')
      (bind (mod "K") ''hl.dsp.focus({ direction = "up" })'')
      (bind (mod "J") ''hl.dsp.focus({ direction = "down" })'')

      # Switch workspaces with mainMod + [0-9]
      (bind (mod "1") (ws "1"))
      (bind (mod "2") (ws "2"))
      (bind (mod "3") (ws "3"))
      (bind (mod "4") (ws "4"))
      (bind (mod "5") (ws "5"))
      (bind (mod "6") (ws "6"))
      (bind (mod "7") (ws "7"))
      (bind (mod "8") (ws "8"))
      (bind (mod "9") (ws "9"))
      (bind (mod "0") (ws "10"))
      # Move through existing workspaces with tab
      (bind (mod "Tab") ''hl.dsp.focus({ workspace = "e+1" })'')

      # Move window to workspace
      (bind (mod "SHIFT + 1") (mvws "1"))
      (bind (mod "SHIFT + 2") (mvws "2"))
      (bind (mod "SHIFT + 3") (mvws "3"))
      (bind (mod "SHIFT + 4") (mvws "4"))
      (bind (mod "SHIFT + 5") (mvws "5"))
      (bind (mod "SHIFT + 6") (mvws "6"))
      (bind (mod "SHIFT + 7") (mvws "7"))
      (bind (mod "SHIFT + 8") (mvws "8"))
      (bind (mod "SHIFT + 9") (mvws "9"))
      (bind (mod "SHIFT + 0") (mvws "10"))

      # Example special workspace (scratchpad)
      (bind (mod "S") ''hl.dsp.workspace.toggle_special("magic")'')
      (bind (mod "SHIFT + S") ''hl.dsp.window.move({ workspace = "special:magic" })'')

      # Scroll through existing workspaces with mainMod + scroll
      (bind (mod "mouse_down") ''hl.dsp.focus({ workspace = "e-1" })'')
      (bind (mod "mouse_up") ''hl.dsp.focus({ workspace = "e+1" })'')

      # Move/resize windows with mainMod + LMB/RMB and dragging
      (bindo (mod "mouse:272") 
        ''hl.dsp.window.drag()''
        ''{ mouse = true }'')
      (bindo (mod "mouse:273") 
        ''hl.dsp.window.resize()''
        ''{ mouse = true }'')

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
      (bind (mod "F") "fullscreen")
      (bind (mod "W") (exec "pkill waybar && waybar"))
      (bind (mod "D") (exec "pkill hyprpicker || hyprpicker --autocopy"))
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
