{
  enable = true;
  settings = {
    autoEnableSources = true;
    experimental = {
      ghost_text = true;
    };
    performance = {
      debounce = 60;
      fetchingTimeout = 200;
      maxViewEntries = 30;
    };
    snippet = {expand = "luasnip";};
    formatting = {
      fields = [
        "kind"
        "abbr"
        "menu"
      ];
    };
    sources = [
      {
        name = "nvim_lsp";
      }
      {
        name = "emoji";
      }
      {
        name = "buffer";
        option.get_bufnrs.__raw = "vim.api.nvim_list_bufs";
        keywordLength = 3;
      }
      {
        name = "path";
        keywordLength = 3;
      }
      {
        name = "luasnip";
        keywordLength = 3;
      }
    ];

    window = {
      completion = {
        border = "solid";
      };
      documentation = {
        border = "solid";
      };
    };

    mapping = {
      "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
      "<C-Space>" = "cmp.mapping.complete()";
    };
  };
}
