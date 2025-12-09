{ config, pkgs, ... } @ inputs:
{
  # Add dolphin and wofi packages
  home.packages = with pkgs; [ kdePackages.dolphin wofi ];

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
