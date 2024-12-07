{config, ...}: {
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
      neocord = {
        enable = true;
        settings = {
          auto_update = true;
          blacklist = [];
          client_id = "1157438221865717891";
          debounce_timeout = 10;
          editing_text = "Editing...";
          enable_line_number = true;
          logo = "https://repository-images.githubusercontent.com/325421844/ecb73f47-cb89-4ee0-a0fd-9743c2f3569a";
          logo_tooltip = "NixVim";
          file_assets = null;
          file_explorer_text = "Browsing...";
          git_commit_text = "Committing changes...";
          global_timer = true;
          line_number_text = "Line %s out of %s";
          log_level = null;
          main_image = "logo";
          plugin_manager_text = "Managing plugins...";
          reading_text = "Reading...";
          show_time = true;
          terminal_text = "Using Terminal...";
          workspace_text = "Working on %s";
        };
      };
      neo-tree.enable = true;
      noice = {
        enable = true;
        settings.presets.command_palette = true;
      };
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
