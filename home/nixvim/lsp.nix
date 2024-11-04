_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          html.enable = true;
          java_language_server.enable = true;
          jsonls.enable = true;
          nixd = {
            enable = true;
            settings = {
              diagnostic.suppress = ["sema-escaping-with"];
            };
          };
          pyright.enable = true;
          sqls.enable = true;
          ts_ls.enable = true;
          yamlls.enable = true;
        };

        keymaps = {
          silent = true;
          diagnostic = {
            # Navigate in diagnostics
            "<leader>k" = "goto_prev";
            "<leader>j" = "goto_next";
          };
          lspBuf = {
            gd = "definition";
            "<C-LeftMouse>" = "definition";
            "<F2>" = "rename";
            gD = "implementation";
            ca = "code_action";
            K = "hover";
          };
        };
      };
      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
          formatters_by_ft = {
            python = ["black"];
            # lua = [ "stylua" ];
            nix = ["nixfmt"];
            markdown = [
              [
                "prettierd"
                "prettier"
              ]
            ];
          };
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
    };
  };
}
