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

    globals = {
      mapleader = " ";
      maplocalleader = " ";

      have_nerd_font = true;
    };

    opts = {
      number = true;
      relativenumber = true;

      showmode = false; # disabled, lualine handles this

      breakindent = true;

      # Save undo history
      undofile = true;

      # Keep sign column on by default
      signcolumn = "yes";

      # Decrease update time
      updatetime = 250;
      # Decrease mapped sequence wait time
      timeoutlen = 300;

      # Configure how new splits should be opened
      # splitright = true;
      # splitbelow = true;

      # Sets how neovim will display certain whitspace characters in the editor
      list = true;
      listchars = { tab = "» ", trail = "·", nbsp = "␣" };

      # Preview substitutions live, as you type!
      inccommand = "split";

      # Show which line your cursor is on
      cursorline = true;

      # Minimal number of screen lines to keep above and below the cursor
      scrolloff = 10;

      # if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
      # instead raise a dialog asking if you wish to save the current file(s)
      confirm = true;
    };

    keymaps = [ 
      {
        mode = "n";
        action = "<cmd>nohlsearch<CR>";
	key = "<Esc>";
      };
      {
        mode = "n"; 
	key = "<leader>q";
	action = lib.nixvim.lua.toLua.Object "vim.diagnostic.setloclist";
      };
    ];

    plugins.lazy.enable = true;
    plugins.lualine.enable = true;

    colorschemes.moonfly.enable = true;
  };
}
