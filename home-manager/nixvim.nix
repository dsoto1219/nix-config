{
  inputs,
  self,
  ...
}: {
  programs.nixvim.enable = true;

  programs.nixvim.options = {
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
    };
  };

  programs.nixvim.plugins = {
    lualine.enable = true;
  };
}
