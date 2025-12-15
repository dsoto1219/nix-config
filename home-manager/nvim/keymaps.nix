{ lib, ... }:
{
  keymaps = [ 
    # Clear highlights on search when pressing <Esc> in normal mode
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
    }
    # Diagnostic keymaps
    {
      mode = "n"; 
      key = "<leader>q";
      action = lib.nixvim.lua.toLua.Object "vim.diagnostic.setloclist";
    }
  ];
}
