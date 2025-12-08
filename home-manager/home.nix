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

    # You can also split up your configuration and import pieces of it here:
    # ./nvim.nix
  ];

  nixpkgs = {
    # You can add overlays here
    overlays = [
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

  home = {
    username = "daniels";
    homeDirectory = "/home/daniels";
  };

  # Add stuff for your user as you see fit:
  programs.neovim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    plugins = with pkgs.vimPlugins; [
      lazy-nvim # package manager
      nvim-lspconfig
      nvim-treesitter.withAllGrammars
      plenary-nvim
      gruvbox-material
    ];
  };

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

  home.packages = with pkgs; [ 
    hello cowsay lolcat sl cmatrix
    fastfetch
    onedrive onedrivegui 
    obsidian 
  ];

  # Let home-manager manage itself
  programs.home-manager.enable = true;

  # Let home-manager manage git, too
  programs.git.enable = true;
  programs.git.settings = {
    user.email = "dsotomail1219@gmail.com";
    user.name = "dsoto1219";
    init.defaultBranch = "main";
  };

  # Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "25.11";
}

