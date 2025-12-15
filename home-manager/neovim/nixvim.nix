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

  plugins = {
    lualine.enable = true;
  };

  colorschemes.moonfly.enable = true;
}
