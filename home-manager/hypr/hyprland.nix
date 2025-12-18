{ config, pkgs, ... } @ inputs:
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.systemd.variables = ["--all"];
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER"; 
      bind = [
        "$mod, F, fullscreen"
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

  programs.waybar.enable = true;
  programs.waybar.settings = {
    mainBar.position = "bottom";
    modules-center = [
      "mpd",
      "idle_inhibitor",
      "pulseaudio",
      "network",
      "power-profiles-daemon",
      "cpu",
      "memory",
      "temperature",
      "backlight",
      "keyboard-state",
      "sway/language",
      "battery",
      "battery#bat2",
      "clock",
      "tray",
      "custom/power"
    ];
  };
  services.hyprpaper.enable = true; # dynamic wallpaper manager
  programs.waylogout.enable = true; # dynamic wallpaper manager
}
