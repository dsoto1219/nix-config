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

    imports = [ ./options.nix ./keymaps.nix ];

    plugins.lazy.enable = true;
    plugins.lualine.enable = true;

    colorschemes.moonfly.enable = true;
  };
}
