{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    ./shell/default.nix
  ];

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

  programs.nixvim = {
    enable = true;
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
