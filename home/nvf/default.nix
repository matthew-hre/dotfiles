{...}: {
  programs.nvf = {
    enable = true;

    settings.vim = {
      viAlias = true;
      vimAlias = true;

      lsp = {
        enable = true;
      };

      languages = {
        enableLSP = true;
        enableTreesitter = true;
        enableFormat = true;

        nix.enable = true;
        ts.enable = true;
        python.enable = true;
      };

      theme = {
        enable = true;
        name = "dracula";
        transparent = true;
      };

      statusline.lualine.enable = true;
      telescope.enable = true;
      binds.whichKey.enable = true;

      binds.cheatsheet.enable = true;

      ui.noice.enable = true;

      ui.borders.plugins.which-key.style = "none";
    };
  };
}
