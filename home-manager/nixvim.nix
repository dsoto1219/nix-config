{
self,
...
}: {
  programs.nixvim.enable = true;

  programs.nixvim.options = {
    viAlias = true;
    vimAlias = true;
    opts = {
      linenumber = true;
      relativelinenumber = true;
    };
  };

  programs.nixvim.plugins = {
    plugins.lualine.enable = true;
  };
}
