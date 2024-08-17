{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./neovim.nix
  ];

  nix = {
    # Garbage Collector
    gc = {
      automatic = true;
      frequency = "monthly";
    };
  };

  home.username = "matthew_hre";
  home.homeDirectory = "/home/matthew_hre";

  home.packages = with pkgs; [
    fastfetch
    nnn

    zip
    xz
    unzip
    p7zip

    ripgrep
    jq
    yq-go
    eza
    fzf

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

    alejandra
    nix-output-monitor

    glow

    btop
    iotop
    iftop

    strace
    ltrace
    lsof

    sysstat
    lm_sensors
    ethtool
    pciutils # lspci
    usbutils # lsusb
  ];

  programs.git = {
    enable = true;
    userName = "Matthew Hrehirchuk";
    userEmail = "matthew_hre@outlook.com";
  };

  # alacritty - a cross-platform, GPU-accelerated terminal emulator
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      import = [pkgs.alacritty-theme.alabaster_dark];
      window = {
        opacity = 0.8;
        blur = true;
        padding = {
          x = 4;
          y = 4;
        };
      };
      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ls = "eza -la --octal-permissions --git";
      z = "zoxide";
      cat = "bat";
      lg = "lazygit";
      rebuild = "sudo nixos-rebuild switch";
    };
    oh-my-zsh = {
      enable = true;
      theme = "strug";
      plugins = [
        "git"
        "npm"
        "history"
        "node"
      ];
    };
  };

  # This value determines the home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update home Manager without changing this value. See
  # the home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
