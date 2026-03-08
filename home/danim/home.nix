# Add things specific to the user danim here
{ inputs, pkgs, ... }: let
  username = "danim";
in {
  home.username = username;
  home.homeDirectory = "/home/${username}";

  imports = [
    ../default.nix
    ./rofi
    ./waybar/waybar.nix
    ./hypr/hyprland.nix

    ./firefox.nix
  ];

  xdg.userDirs.createDirectories = true;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    onedrivegui
    obsidian 
    kdePackages.ksshaskpass # for obsidian-git auth
    zotero
    mission-center
    vesktop
    pamixer
    qimgv
    steamcmd steam-tui
  ];

  programs.onedrive.enable = true;

  stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/monokai.yaml";
    image = ../../assets/sekiro-vs-father-sunset.png;
    cursor = {
      package = pkgs.bibata-cursors;
      name = "Bibata-Modern-Classic";
      size = 16;
    };
  };

  home.persistence."/persistent" = {
    directories = [
      "Documents"
      "Downloads"
      "Music"
      "OneDrive"
      "Pictures"
      "Videos"
      { directory = ".gnupg"; mode = "0700"; }
      { directory = ".ssh"; mode = "0700"; }
      { directory = ".nixops"; mode = "0700"; }
      { directory = ".local/share/keyrings"; mode = "0700"; }
      ".local/share/direnv"
    ];
    files = [ ".screenrc" ]; 
  };
}
