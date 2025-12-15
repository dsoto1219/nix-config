{
  lib,
  ...
}: {
  enable = true;

  options = {
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
    };
  };

  plugins = {
    lualine.enable = true;
  };
}
