{
  pkgs,
  hostname,
  lib,
  inputs,
  ...
}: let
  toad = hostname == "toad";
in {
  imports =
    [
      inputs.nvf.homeManagerModules.default
      inputs.niri.homeModules.niri

      ./fastfetch
      ./fuzzel
      ./shell
      ./nvf
      ./spotify-tui
    ]
    ++ lib.optional toad ./niri;

  home.username = "matthew_hre";
  home.homeDirectory = "/home/matthew_hre";

  home.packages = with pkgs; [
    zip
    xz
    unzip
    p7zip

    ripgrep
    eza
    tldr

    gh
    lazygit
    lazydocker

    alejandra
    nix-output-monitor

    glow

    strace
    ltrace
    pciutils
    usbutils
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  programs.git = {
    enable = true;
    userName = "Matthew Hrehirchuk";
    userEmail = "matthew_hre@outlook.com";
    extraConfig = {
      include = {
        path = "/home/matthew_hre/.config/git/themes.gitconfig";
      };
      core = {pager = "bat";};
      blame = {pager = "bat";};
      delta = {
        features = "line-numbers decorations";
        hyperlinks = true;
        syntax-theme = "Dracula";
        plus-style = ''syntax "#003800"'';
        minus-style = ''syntax "#3f0001"'';
      };
    };
  };

  programs.fzf = {
    enable = true;
    colors = {
      fg = "#f8f8f2";
      "fg+" = "#f8f8f2";
      bg = "-1";
      "bg+" = "#44475a";
      hl = "#bd93f9";
      "hl+" = "#bd93f9";
      gutter = "-1";
      info = "#ffb86c";
      prompt = "#50fa7b";
      pointer = "#50FA7b";
      marker = "#50FA7b";
      spinner = "#ffb86c";
      header = "#6272a4";
    };
  };

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula";
      theme_background = false;
    };
  };

  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };

  programs.vscode.enable = true;

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  nix = {
    # Garbage Collector
    gc = {
      automatic = true;
      frequency = "monthly";
    };
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
