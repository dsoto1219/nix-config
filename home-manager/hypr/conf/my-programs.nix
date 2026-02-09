###################
### MY PROGRAMS ###
###################

# See https://wiki.hypr.land/Configuring/Keywords/
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    kdePackages.dolphin # file manager
    hyprlauncher
  ];

  programs.kitty.enable = true;

  wayland.windowManager.hyprland.settings = {
    # Set programs that you use
    "$terminal" = "kitty";
    "$fileManager" = "dolphin";
    "$menu" = "hyprlauncher";
  };
}
