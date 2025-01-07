_: {
  programs.nixvim = {
    plugins = {
      lsp = {
        enable = true;
        inlayHints = true;
        servers = {
          bashls.enable = true;
          cssls.enable = true;
          eslint.enable = true;
          gopls = {
            enable = true;
          };
          html.enable = true;
          java_language_server.enable = true;
          jsonls.enable = true;
          lua_ls = {
            enable = true;
          };
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
            gd = {
              action = "definition";
              desc = "Goto Definition";
            };
            gr = {
              action = "references";
              desc = "Goto References";
            };
            gD = {
              action = "declaration";
              desc = "Goto Declaration";
            };
            gI = {
              action = "implementation";
              desc = "Goto Implementation";
            };
            gT = {
              action = "type_definition";
              desc = "Type Definition";
            };
            "<leader>cr" = {
              action = "rename";
              desc = "Rename";
            };
          };
        };
      };

      lsp-lines.enable = true;

      conform-nvim = {
        enable = true;
        settings = {
          format_on_save = {
            lspFallback = true;
            timeoutMs = 500;
          };
          notify_on_error = true;

          formatters_by_ft = {
            html = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            css = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            java = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            javascript = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            javascriptreact = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            typescript = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            typescriptreact = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            python = ["black"];
            lua = ["stylua"];
            nix = ["alejandra"];
            markdown = [
              [
                "prettierd"
                "prettier"
              ]
            ];
            yaml = [
              "yamllint"
              "yamlfmt"
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
    extraConfigLua = ''
      require'lspconfig'.lua_ls.setup {
        on_init = function(client)
          if client.workspace_folders then
            local path = client.workspace_folders[1].name
            if vim.loop.fs_stat(path..'/.luarc.json') or vim.loop.fs_stat(path..'/.luarc.jsonc') then
              return
            end
          end

          client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
            runtime = {
              version = 'LuaJIT'
            },
            workspace = {
              checkThirdParty = false,
              library = {
                "''${3rd}/love/library",
                "''${3rd}/love2d/library"
              }
            }
          })
        end,
        settings = {
          Lua = {
            workspace = {
              checkThirdParty = false,
              library = {
                "''${3rd}/love/library",
                "''${3rd}/love2d/library"
              }
            }
          }
        }
      }
    '';
  };
}
