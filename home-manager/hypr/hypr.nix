{ config, pkgs, ... } @ inputs:
{
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    wofi # menu manager
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
