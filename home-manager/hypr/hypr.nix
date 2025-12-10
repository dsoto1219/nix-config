{ config, pkgs, ... } @ inputs:
{
  # Add must-have packages from docs
  home.packages = with pkgs; [ 
    dunst # notification daemon
    pipewire wireplumber # pipewire: for screensharing
    qt5-wayland qt6-wayland # Qt Wayland Support
    hyprpolkitagent #  authentication agent
    # nerd fonts specified in ./nixos/common/default.nix
    kdePackages.dolphin 
    wofi 
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
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
}
