{ lib, ... }:
{
  keymaps = [ 
    # Clear highlights on search when pressing <Esc> in normal mode
    {
      mode = "n";
      action = "<cmd>nohlsearch<CR>";
ey = "<Esc>";
    }
    # Diagnostic keymaps
    {
      mode = "n"; 
ey = "<leader>q";
ction = lib.nixvim.lua.toLua.Object "vim.diagnostic.setloclist";
    }
  ];
}
