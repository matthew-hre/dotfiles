{
  programs.nvf.settings.vim.languages = {
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
      lsp = {
        enable = true;
        server = "pyright";
      };
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
}
