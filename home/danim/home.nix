# Add things specific to the user danim here
{ pkgs, ... }: let
  username = "danim";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ./onedriver/onedriver.nix
    ./waybar/waybar.nix
    ./hypr/hyprland.nix

    ./librewolf.nix
    # ./firefox.nix
  ];

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    obsidian 
    kdePackages.ksshaskpass # for obsidian-git auth
    zotero
    mission-center
    vesktop
    pamixer
  ];

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
    image = ../../assets/sekiro-vs-father.png;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };
}
