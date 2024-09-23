{
  alpha = import ./alpha.nix;

  lsp = import ./lsp.nix;

  which-key = import ./which-key.nix;

  neo-tree = import ./neo-tree.nix;

  cmp = import ./cmp.nix;

  cmp-nvim-lsp = {enable = true;}; # lsp
  cmp-buffer = {enable = true;};
  cmp-path = {enable = true;}; # file system paths
  cmp_luasnip = {enable = true;}; # snippets
  cmp-cmdline = {enable = false;}; # autocomplete for cmdline

  goyo = {
    enable = true;
  };

  lualine = {enable = true;};

  luasnip = {
    enable = true;
    settings = {
      enable_autosnippets = true;
      store_selection_keys = "<Tab>";
    };
  };

  lspkind = {
    enable = true;
    symbolMap = {
      Copilot = "";
    };
    extraOptions = {
      maxwidth = 50;
      ellipsis_char = "...";
    };
  };

  obsidian = import ./obsidian.nix;

  treesitter.enable = true;

  telescope.enable = true;

  markdown-preview = {
    enable = true;
    settings = {
      autoStart = true;
      browser = "firefox";
    };
  };

  copilot-lua = {
    enable = true;
    suggestion = {
      enabled = true;
    };
    panel = {
      enabled = false;
    };
    filetypes = {
      markdown = true;
    };
  };
}
