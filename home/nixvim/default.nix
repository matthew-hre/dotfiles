{config, ...}: {
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";

    opts = {
      relativenumber = true;
      incsearch = true;
    };

    colorschemes.dracula.enable = true;
    plugins.lualine.enable = true;
    plugins.nix.enable = true;

    plugins.treesitter.enable = true;

    plugins.telescope.enable = true;

    plugins.harpoon = {
      enable = true;
      keymaps.addFile = "<leader>a";
    };

    plugins.lsp = {
      enable = true;

      servers = {
        tsserver.enable = true;
        html.enable = true;
        nil-ls.enable = true;
        eslint.enable = true;
      };

      keymaps = {
        silent = true;
        diagnostic = {
          "<leader>k" = "goto_prev";
          "<leader>j" = "goto_next";
        };

        lspBuf = {
          gd = "definition";
          K = "hover";
        };
      };
    };

    plugins.cmp = {
      enable = true;
      autoEnableSources = true;
    };

    plugins.oil.enable = true;

    plugins.luasnip.enable = true;

    plugins.neo-tree.enable = true;

    plugins.which-key.enable = true;
  };
}
