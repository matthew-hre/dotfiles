{ config, ... }:

{
  programs.nixvim = {
    enable = true;

    options = {
      relativenumber = true;
      incsearch = true;
    };

    colorschemes.alabaster_dark.enable = true;
    plugins.lualine.enable = true;
    plugins.nix.enable = true;

    plugins.treesitter.enable = true;

    plugins.telescope.enable = true;

    plugins.harpoon = {
      enable = true;
      keymaps.addFile = "<leader>a";
    };

    plugins.lsp = {
      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          gd = "definition";
          K  = "hover";
        };
      };
    };
  };
}
