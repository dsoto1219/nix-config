{
  lib,
  ...
}: {
  viAlias = true;
  vimAlias = true;

  opts = {
    number = true;
    relativenumber = true;
  };

  plugins.lualine = {
    enable = true;
    settings = {
      vim.opt.showmode = false;
    };
  };

  colorschemes.moonfly.enable = true;
}
