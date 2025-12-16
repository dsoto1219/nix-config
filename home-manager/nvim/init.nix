{
  inputs,
  self,
  pkgs,
  config,
  ...
}: {
  imports = [ inputs.nixvim.homeModules.nixvim ];

  programs.nixvim = {
    enable = true;

    viAlias = true;
    vimAlias = true;
    vimdiffAlias = true;

    clipboard.register = "unnamedplus";

    imports = [ ./options.nix ./keymaps.nix ];

    plugins.mini-statusline = {
      enable = true;
      settings = {
        use_icons = true;
      };
    };
    plugins.vim-surround.enable = true;
    plugins.todo-comments.enable = true;
    plugins.gitsigns.enable = true;

    # Lazy loading
    plugins.lz-n.enable = true;

    # Style checkers and maintainers
    plugins.guess-indent.enable = true;
    plugins.conform-nvim = {
      enable = true;
      autoInstall.enable = true;
      lazyLoad.settings.cmd = "Conform";
    };

    # Markdown preview
    plugins.glow = {
      enable = true;
      lazyLoad.settings.ft = "markdown";
    };

    plugins.lspconfig.enable = true;
    lsp.servers = {
      asm_lsp.enable = true;
      emmet_language_server.enable = true;
      rust_analyzer.enable = true;
      nixd.enable = true;
    };

    extraPlugins = [
      pkgs.vimPlugins.nvim-autopairs
    ];
    
    # A nice, dark colorscheme
    colorschemes.moonfly.enable = true;
  };
}
