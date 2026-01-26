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
      "$shiftMod" = "SUPER shift"; 
      bind = [
        "$mod, F, fullscreen"
        # Screenshot a window with SUPER + PrintScr
        "$mod, PRINT, exec, hyprshot -m window"
        # Screenshot a monitor with PrintScr
        ", PRINT, exec, hyprshot -m output"
        # Screenshot a region with SUPER + Shift + S
        "$shiftMod, S, exec, hyprshot -m region" 
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
  programs.swaylock.enable = true; # lockout screen manager
  programs.waylogout.enable = true;
}
