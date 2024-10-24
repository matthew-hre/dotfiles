{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixvim.homeManagerModules.nixvim
    inputs.spicetify-nix.homeManagerModules.default
    ./fastfetch/default.nix
    ./shell/default.nix
    ./nixvim/default.nix
    ./rofi/rofi.nix
    ./spicetify/default.nix
  ];

  home.username = "matthew_hre";
  home.homeDirectory = "/home/matthew_hre";

  home.packages = with pkgs; [
    nnn

    bat

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
    pciutils # lspci
    usbutils # lsusb
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

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "Dracula";
      theme_background = false;
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
