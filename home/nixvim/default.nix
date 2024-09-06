{...}: {
  programs.nixvim = {
    enable = true;

    opts = import ./config/options.nix;

    globals.mapleader = " ";

    viAlias = true;
    vimAlias = true;

    clipboard = {
      providers.xsel.enable = true;

      register = "unnamedplus";
    };

    keymaps = [
      {
        mode = "v";
        key = "<S-Tab>";
        action = "<gv";
        options.desc = "Unindent line";
      }
      {
        mode = "v";
        key = "<Tab>";
        action = ">gv";
        options.desc = "Indent line";
      }
      {
        mode = "!";
        key = "<C-l>";
        action = "<c-g>u<Esc>[s1z=`]a<c-g>u";
        options.desc = "Spell correct previous word";
      }
    ];

    colorschemes = import ./config/colorscheme.nix;

    plugins = import ./plugins/default.nix;

    # plugins.lualine.enable = true;
    # plugins.nix.enable = true;

    # plugins.treesitter.enable = true;

    # plugins.telescope.enable = true;

    # plugins.harpoon = {
    #   enable = true;
    #   keymaps.addFile = "<leader>a";
    # };

    # plugins.lsp = {
    # enable = true;

    # servers = {
    #  tsserver.enable = true;
    #  html.enable = true;
    #  nil-ls.enable = true;
    #   eslint.enable = true;
    # };

    # keymaps = {
    #  silent = true;
    # diagnostic = {
    #   "<leader>k" = "goto_prev";
    #    "<leader>j" = "goto_next";
    #   };

    #     lspBuf = {
    #       gd = "definition";
    #       K = "hover";
    #     };
    #   };
    # };

    # plugins.cmp = {
    #   enable = true;
    #   autoEnableSources = true;
    # };

    # plugins.oil.enable = true;

    # plugins.luasnip.enable = true;

    # plugins.neo-tree.enable = true;

    # plugins.which-key.enable = true;
  };
}
