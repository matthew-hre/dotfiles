{
  pkgs,
  inputs,
  ...
}: {
  home.packages = [
    inputs.rpc-lsp.packages.${pkgs.system}.default
  ];

  programs.helix = {
    enable = true;

    extraPackages = [inputs.rpc-lsp.packages.${pkgs.system}.default];

    languages = {
      language-server = {
        discord-rpc = {
          command = "${inputs.rpc-lsp.packages.${pkgs.system}.default}/bin/discord-rpc-lsp-flake";
        };
      };

      language = [
        {
          name = "nix";
          language-servers = ["discord-rpc"];
        }
      ];
    };
    settings = {
      theme = "dracula";
      editor = {
        color-modes = true;
        cursorline = true;
        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };
        undercurl = true;
        true-color = true;
        lsp = {
          display-messages = true;
          display-inlay-hints = true;
        };
        auto-pairs = true;
        clipboard-provider = "wayland";
      };
    };
  };
}
