{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

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
