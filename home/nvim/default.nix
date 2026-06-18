{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

  programs.mnw = {
    enable = true;
    aliases = [ "vi" "vim" ];
    extraBinPath = with pkgs; [ 
      ripgrep
      fzf
      tree-sitter
      gcc rpclib
    ];
    plugins.dev = {
      config = {
        pure = ./config;
	impure = "/home/danim/Dev/nix-config/home/nvim/config/";
      };
    };
  };
}
