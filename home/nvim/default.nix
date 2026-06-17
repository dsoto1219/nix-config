{ inputs, pkgs, ... }:
{
  imports = [ inputs.mnw.homeManagerModules.mnw ];

  programs.mnw = {
    enable = true;
    luaFiles = [ 
      ./init.lua # Main file
      ./lua/custom/plugins/init.lua 
      ./lua/kickstart/health.lua
      # Extra Provided Plugins
      ./lua/kickstart/plugins/autopairs.lua
      ./lua/kickstart/plugins/debug.lua
      ./lua/kickstart/plugins/gitsigns.lua
      ./lua/kickstart/plugins/indent_line.lua
      ./lua/kickstart/plugins/lint.lua
      ./lua/kickstart/plugins/neo-tree.lua
    ];
    aliases = [ "vi" "vim" ];
    extraBinPath = with pkgs; [ 
      ripgrep
      fzf
      tree-sitter
      gcc rpclib
    ];
  };
}
