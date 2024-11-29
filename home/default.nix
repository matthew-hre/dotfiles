{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.nvf.homeManagerModules.default

    ./fastfetch
    ./shell
    ./nixvim/default.nix
    ./rofi/rofi.nix
    ./spotify-tui
  ];

  home.username = "matthew_hre";
  home.homeDirectory = "/home/matthew_hre";

  home.packages = with pkgs; [
    nnn

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    tldr

    mtr
    iperf3
    dnsutils
    ldns
    aria2
    socat
    nmap
    ipcalc

    cowsay
    file
    which
    tree
    gnused
    gnutar
    gawk
    zstd
    gnupg

    gh
    lazygit

    alejandra
    nix-output-monitor

    glow

    iotop
    iftop

    strace
    ltrace
    lsof

    sysstat
    lm_sensors
    ethtool
    pciutils
    usbutils
  ];

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
