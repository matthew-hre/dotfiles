{
  config,
  isVm,
  lib,
  pkgs,
  ...
}: {
  programs.nixvim = {
    plugins = {
      bufferline.enable = true;
      comment.enable = true;
      fugitive.enable = true;
      gitsigns.enable = true;
      harpoon.enable = true;
      lualine.enable = true;
      luasnip = {
        enable = true;
        settings = {
          enable_autosnippets = true;
          store_selection_keys = "<Tab>";
        };
      };
      nvim-autopairs.enable = true;
      nvim-tree.enable = true;
      obsidian = {
        enable = true;
        settings = {
          ui = {
            enable = true;

            checkboxes = {
              " " = {
                char = "󰄱";
                hl_group = "ObsidianTodo";
              };
              "x" = {
                char = "";
                hl_group = "ObsidianDone";
              };
              ">" = {
                char = "";
                hl_group = "ObsidianRightArrow";
              };
              "~" = {
                char = "󰰱";
                hl_group = "ObsidianTilde";
              };
              "!" = {
                char = "";
                hl_group = "ObsidianImportant";
              };
            };

            external_link_icon = {
              char = "";
              hl_group = "ObsidianExtLinkIcon";
            };
          };
          workspaces = [
            {
              name = "personal";
              path = "~/University/Obsidian/matthew_hre";
            }
          ];
        };
      };
      project-nvim.enable = true;
      treesitter = {
        enable = true;
        settings.indent.enable = true;

        grammarPackages = with config.programs.nixvim.plugins.treesitter.package.builtGrammars; [
          bash
          c
          cmake
          comment
          cpp
          css
          csv
          diff
          dockerfile
          fish
          gitcommit
          gitignore
          git_rebase
          graphql
          html
          ini
          javascript
          json
          jsonc
          lua
          make
          markdown
          markdown_inline
          meson
          ninja
          nix
          prisma
          po
          python
          rasi
          requirements # pip requirements.txt
          rst
          rust
          sql
          toml
          tsv
          tsx
          typescript
          vim
          vimdoc
          xml
          yaml
        ];
      };
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
        };
        keymaps = {
          "<leader>pf" = {
            action = "git_files";
            options.desc = "Telescope git files";
          };
          "<leader>fc" = {
            action = "git_status";
            options.desc = "Telescope git status";
          };
          "<leader>fb" = {
            action = "buffers";
            options.desc = "Telescope buffers";
          };
          "<leader>fr" = {
            action = "oldfiles";
            options.desc = "Telescope recent files";
          };
          "<leader>fq" = {
            action = "quickfix";
            options.desc = "Telescope quickfix";
          };
          "<leader>gb" = {
            action = "git_branches";
            options.desc = "Telescope git branches";
          };
          "<leader>/" = {
            action = "live_grep";
            options.desc = "Telescope grep";
          };
          # TODO: harpoon marks?
          # TODO: zellij windows?
        };
      };
      vim-surround.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };
  };
}
