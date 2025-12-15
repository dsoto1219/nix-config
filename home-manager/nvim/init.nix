{
  inputs,
  self,
  config,
  ...
}: {
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    globals = {
      mapleader = ' ';
      maplocalleader = ' ';

      have_nerd_font = true;
    };

    opts = {
      number = true;
      relativenumber = true;

      showmode = false; # disabled, lualine handles this
    };

    plugins.lualine.enable = true;

    colorschemes.moonfly.enable = true;
  };
}
