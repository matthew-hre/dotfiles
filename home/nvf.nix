{...}: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        viAlias = true;
        vimAlias = true;

        spellcheck.enable = true;

        lsp = {
          formatOnSave = true;
          lspkind.enable = true;
          lightbulb.enable = true;
          lspsaga.enable = false;
          trouble.enable = true;
          lspSignature.enable = true;
          otter-nvim.enable = true;
          lsplines.enable = true;
        };

        languages = {
          enableLSP = true;
          enableFormat = true;
          enableTreesitter = true;

          nim.enable = false;
          nix.enable = true;

          markdown.enable = true;
          html.enable = true;
          css.enable = true;
          sql.enable = true;
          java.enable = true;
          ts.enable = true;
          lua.enable = true;
          zig.enable = true;
          python.enable = true;
          bash.enable = true;
          tailwind.enable = true;
        };

        visuals = {
          enable = true;
          nvimWebDevicons.enable = true;
          smoothScroll.enable = true;
          indentBlankline.enable = true;

          cursorline = {
            enable = true;
            lineTimeout = 0;
          };
        };

        statusline = {
          lualine = {
            enable = true;
            theme = "dracula";
          };
        };

        theme = {
          enable = true;
          name = "dracula";
          transparent = true;
        };

        autopairs.enable = true;

        autocomplete = {
          enable = true;
          type = "nvim-cmp";
        };

        filetree = {
          nvimTree = {
            enable = true;
          };
        };

        tabline = {
          nvimBufferline.enable = true;
        };

        treesitter.context.enable = true;

        binds = {
          whichKey.enable = true;
          cheatsheet.enable = true;
        };

        telescope.enable = true;

        git = {
          enable = true;
          gitsigns.enable = true;
          gitsigns.codeActions.enable = false;
        };

        notify = {
          nvim-notify.enable = true;
        };

        notes = {
          todo-comments.enable = true;
        };

        ui = {
          borders.enable = true;
          colorizer.enable = true;
          illuminate.enable = true;
        };

        presence = {
          neocord.enable = true;
        };
      };
    };
  };
}
