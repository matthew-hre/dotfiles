{
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      syntaxHighlighting = true;
      useSystemClipboard = true;

      keymaps = [
        {
          mode = "!";
          key = "<C-l>";
          action = "<c-g>u<Esc>[s1z=`]a<c-g>u";
        }
      ];

      binds.cheatsheet.enable = true;
      binds.whichKey.enable = true;

      lsp = {
        enable = true;
        formatOnSave = true;
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;
        enableExtraDiagnostics = true;

        html = {
          enable = true;
          treesitter.enable = true;
          treesitter.autotagHtml = true;
        };

        go = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        java = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        lua = {
          enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        markdown = {
          enable = true;
          format.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        nix = {
          enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        python = {
          enable = true;
          dap.enable = true;
          format.enable = true;
          lsp.enable = true;
          treesitter.enable = true;
        };

        tailwind = {
          enable = true;
          lsp.enable = true;
        };

        ts = {
          enable = true;
          extensions.ts-error-translator.enable = true;
          extraDiagnostics.enable = true;
          format.enable = true;
          format.type = "prettierd";
          lsp.enable = true;
          treesitter.enable = true;
        };
      };

      theme = {
        enable = true;
        name = "dracula";
      };

      statusline.lualine = {
        enable = true;
        globalStatus = true;
        icons.enable = true;
      };

      telescope.enable = true;
      presence.neocord.enable = true;

      ui.noice.enable = true;

      ui.borders.plugins.which-key.style = "solid";

      visuals.nvim-web-devicons.enable = true;
    };
  };
}
