{ pkgs, ... }:
{
  programs.mnw = {
    enable = true;
    luaFiles = ./init.lua;
    aliases = [ "vi" "vim" ];
    extraBinPath = with pkgs; [ 
      rg
      fzf
    ];
  };
}
