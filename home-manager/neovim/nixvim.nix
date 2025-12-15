{
  lib,
  ...
}: {
  viAlias = true;
  vimAlias = true;

  opts = {
    number = true;
    relativenumber = true;

    showmode = false; # disabled, lualine handles this
  };

  plugins.lualine.enable = true;

  colorschemes.moonfly.enable = true;
}
