{ pkgs, ... }: {
  programs.helix = {
    enable = true;
    settings = {
      theme = "dracula_transparent";
      editor = {
        line-number = "relative";
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        indent-guides = {
          character = "╎";
          render = true;
        };
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        statusline = {
          left = [ "mode" "spinner" "version-control" "file-name" ];
        };
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
    themes = {
      dracula_transparent = {
        "inherits" = "dracula";
        "ui.background" = { };
      };
    };
  };
}
