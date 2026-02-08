{ inputs, lib, config, pkgs, ... }:
{
  imports = [
    inputs.hyprland.homeManagerModules.default # this shouldn't work---it's not how the docs say to do it---but it does
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    hyprshot
    unstable.hyprshutdown
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = let
    hyprland-pkgs = inputs.hyprland.packages."${pkgs.stdenv.hostPlatform.system}";
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
  services.hyprpaper.settings = {
    wallpaper = [
      ",path = ../../assets/planet-bottom.jpg"
    ];
  };
  programs.wlogout.enable = true;
}
