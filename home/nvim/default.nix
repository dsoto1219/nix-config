{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

  programs.mnw = {
    enable = true;
    initLua = ''
      require("config")
    '';
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
      }
    }
  };
}
