{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

  # Enable dynamic linking
  programs.nix-ld.enable = true;

  programs.mnw = {
    enable = true;
    luaFiles = [ ./init.lua ];
    aliases = [ "vi" "vim" ];
    extraBinPath = with pkgs; [ 
      ripgrep
      fzf
      tree-sitter
      gcc rpclib
    ];
  };
}
