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
      settings.formatters_by_ft = {
        cpp = [ "clang_format" ];
        nix = [ "nixfmt" ];
        "_" = [
          "squeeze_blanks"
          "trim_whitespace"
          "trim_newlines"
        ];
      };
    };

    # Markdown preview
    plugins.glow.enable = true;

    plugins.lspconfig.enable = true;
    lsp.servers = {
      asm_lsp.enable = true;
      emmet_language_server.enable = true;
      rust_analyzer.enable = true;
      nixd.enable = true;
    };

    extraPlugins = [
      pkgs.vimPlugins.nvim-autopairs
      (pkgs.vimUtils.buildVimPlugin {
        name = "kerbovim";
        src = pkgs.fetchFromGitHub {
            owner = "Freedzone";
            repo = "kerbovim";
            rev = "c6bdc3a19e0b84085113dafb5b4ab6bf668c698b";
            hash = "sha256-2lzHOGZe7rizPayFsI16+FVNWlm+3yITQlc4NhjsFRM=";
        };
    })];

    plugins.lint.enable = true;
    plugins.lint.lintersByFt = {
      clojure = [
        "clj-kondo"
      ];
      dockerfile = [
        "hadolint"
      ];
      inko = [
        "inko"
      ];
      janet = [
        "janet"
      ];
      json = [
        "jsonlint"
      ];
      markdown = [
        "vale"
      ];
      rst = [
        "vale"
      ];
      ruby = [
        "ruby"
      ];
      terraform = [
        "tflint"
      ];
      text = [
        "vale"
      ];
    };
    
    # A nice, dark colorscheme
    colorschemes.moonfly.enable = true;
  };
}
