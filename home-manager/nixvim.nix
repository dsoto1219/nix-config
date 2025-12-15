{
  inputs,
  self,
  ...
}: let
  nixvim = inputs.nixvim.homeModules.nixvim;
in {
  nixvim.enable = true;

  nixvim.options = {
    viAlias = true;
    vimAlias = true;
    opts = {
      linenumber = true;
      relativelinenumber = true;
    };
  };

  nixvim.plugins = {
    lualine.enable = true;
  };
}
