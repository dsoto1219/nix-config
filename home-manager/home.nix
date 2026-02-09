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
    ./shells.nix
    ./onedriver.nix
    ./hypr/hyprland.nix
    ./nvim/init.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
      # inputs.self.overlays.additions
      inputs.self.overlays.modifications
      inputs.self.overlays.unstable-packages
      # If you want to use overlays exported from other flakes:
      # neovim-nightly-overlay.overlays.default

      # Or define it inline, for example:
      # (final: prev: {
      #   hi = final.hello.overrideAttrs (oldAttrs: {
      #     patches = [ ./change-hello-to-hi.patch ];
      #   });
      # })
    ];
    # Configure your nixpkgs instance
    config = {
      # Disable if you don't want unfree packages
      allowUnfree = true;
      # Workaround for https://github.com/nix-community/home-manager/issues/2942
      allowUnfreePredicate = _: true;
    };
  };

  stylix.enable = true;
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/gruvbox-dark-hard.yaml";
  stylix.image = ../assets/house-in-middle-of-mountain.jpg;

  # Add stuff for your user as you see fit:
  home.packages = with pkgs; [ 
    hello cowsay lolcat sl cmatrix
    fastfetch
    obsidian 
    kdePackages.ksshaskpass # for obsidian-git auth
    zotero
    zathura
    mission-center
    code2prompt
    vesktop
    weather
    pamixer
    ruby
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}

