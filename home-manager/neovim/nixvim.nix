{
  lib,
  ...
}: {
  viAlias = true;
  vimAlias = true;

  options = {
    number = true;
    relativenumber = true;
  };

  plugins = {
    lualine.enable = true;
  };
}
