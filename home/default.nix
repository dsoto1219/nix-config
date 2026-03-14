# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
  inputs,
  lib,
  config,
  pkgs,
  ...
}: {
  # You can import other home-manager modules here
  imports = [
    # If you want to use home-manager modules from other flakes (such as nix-colors):
    # inputs.nix-colors.homeManagerModule
    inputs.stylix.homeModules.stylix

    # You can also split up your configuration and import pieces of it here:
    ./git.nix
    ./shells.nix
    ./nvim/init.nix
  ];

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    hello cowsay lolcat sl cmatrix fastfetch
    yazi
    zathura
    code2prompt
    weather
    ruby
    lazygit
    ffmpeg
    devenv

    # Fonts
    nerd-fonts.jetbrains-mono
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-gtk;
    extraConfig = builtins.readFile ./.emacs.d/init.el;
  };

  fonts.fontconfig.enable = true;

  stylix.enable = true;

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}

