{ inputs, lib, config, pkgs, ... }:
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  imports = [
    inputs.hyprland.packages."${system}"
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    hyprshot
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = let
    hyprland-pkgs = inputs.hyprland.packages."${system}";
  in {
    enable = true;
    # set the flake package
    package = hyprland-pkgs.hyprland; 
    portalPackage = hyprland-pkgs.xdg-desktop-portal-hyprland; 
    systemd.variables = ["--all"];
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
    extraConfig = builtins.readFile ./conf/hyprland.conf;
  };

  services.dunst.enable = true; # notification manager
  programs.wofi.enable = true; # menu manager

  programs.hyprlock.enable = true;
  xdg.configFile.hyprlock = {
    source = ./conf/hyprlock.conf;
    target = "hypr/hyprlock.conf";
  };

  services.hypridle.enable = true;
  xdg.configFile.hypridle = {
    source = ./conf/hypridle.conf;
    target = "hypr/hypridle.conf";
  };

  services.hyprpaper.enable = true; # dynamic wallpaper manager
  programs.wlogout.enable = true;
}
