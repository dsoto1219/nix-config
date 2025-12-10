{ config, pkgs, ... } @ inputs:
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland.settings = {
    "$mod" = "SUPER"; 
    bind = [
      "$mod, F, fullscreen"
    ];
    input = {
      touchpad = {
        natural_scroll = true;
      };
    };
    extraConfig = builtins.readFile ./hyprland.conf;
  };

  services.dunst.enable = true; # notification manager
  programs.wofi.enable = true; # menu manager
}
