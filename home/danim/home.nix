# Add things specific to the user danim here
{ inputs, pkgs, ... }: let
  username = "danim";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ../default.nix
    ./rofi
    ./persistence.nix
    ./waybar/config.nix
    ./hypr/hyprland.nix
    # ./hyprpanel/hyprpanel.nix

    ./firefox.nix
  ];

  xdg.userDirs.createDirectories = true;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    # unstable.onedrivegui
    obsidian 
    kdePackages.ksshaskpass # for obsidian-git auth
    zotero
    mission-center
    vesktop
    pamixer
    qimgv
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ../../assets/sekiro-vs-father-sunset.png;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
