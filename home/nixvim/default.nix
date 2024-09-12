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
      {
        key = "<leader>n";
        options.silent = true;
        action = "<cmd>Neotree toggle<CR>";
      }
    ];

    colorschemes = import ./config/colorscheme.nix;

    plugins = import ./plugins/default.nix;

    extraConfigLua = ''
      require("copilot").setup({
        suggestion = {
          enabled = true,
          auto_trigger = true,
          keymap = {
            accept = "<C-Tab>",
          },
        },
        panel = { enabled = false },
      })

      luasnip = require("luasnip")

      kind_icons = {
          Text = "󰊄",
          Method = "",
          Function = "󰡱",
          Constructor = "",
          Field = "",
          Variable = "󱀍",
          Class = "",
          Interface = "",
          Module = "󰕳",
          Property = "",
          Unit = "",
          Value = "",
          Enum = "",
          Keyword = "",
          Snippet = "",
          Color = "",
          File = "",
          Reference = "",
          Folder = "",
          EnumMember = "",
          Constant = "",
          Struct = "",
          Event = "",
          Operator = "",
          TypeParameter = "",
      }

      local cmp = require'cmp'

      cmp.setup.cmdline({'/', "?" }, {
         sources = {
           { name = 'buffer' }
         }
       })

      -- Set configuration for specific filetype.
       cmp.setup.filetype('gitcommit', {
         sources = cmp.config.sources({
           { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
         }, {
           { name = 'buffer' },
         })
       })

       -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
       cmp.setup.cmdline(':', {
         sources = cmp.config.sources({
           { name = 'path' }
         }, {
           { name = 'cmdline' }
         }),
      })
    '';

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
