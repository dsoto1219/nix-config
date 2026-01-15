{ config, pkgs, ... } @ inputs:
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    hyprshot
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER"; 
      bind = [
        "$mod, F, fullscreen"
        # Screenshot a window with SUPER + PrintScr
        "bind = $mainMod, PRINT, exec, hyprshot -m window"
        # Screenshot a monitor with PrintScr
        "bind = , PRINT, exec, hyprshot -m output"
        # Screenshot a region with SUPER + Shift + S
        "bind = $shiftMod, S, exec, hyprshot -m region" 
      ];
      input = {
        touchpad = {
          natural_scroll = true;
        };
      };
    };
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services.dunst.enable = true; # notification manager
  programs.wofi.enable = true; # menu manager

  imports = [ ./waybar.nix ];
  services.hyprpaper.enable = true; # dynamic wallpaper manager
  programs.waylogout.enable = true;
}
