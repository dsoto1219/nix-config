{ config, pkgs, ... } @ inputs:
let
  system = pkgs.stdenv.hostPlatform.system;
in {
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
  ];

  # Hyprland Configuration
  programs.kitty.enable = true;
  wayland.windowManager.hyprland = {
    enable = true;
    # set the flake package
    package = inputs.hyprland.packages."${system}".hyprland; 
    portalPackage = inputs.hyprland.packages."${system}".xdg-desktop-portal-hyprland; 

    # config
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
}
