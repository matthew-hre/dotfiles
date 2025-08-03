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
      inputs.node-modules-gc.homeManagerModules.node-modules-gc

      ./bat.nix
      ./btop.nix
      ./fastfetch
      ./fuzzel.nix
      ./fzf.nix
      ./git.nix
      ./helix.nix
      ./shell
      ./nvf
    ]
    ++ lib.optional toad ./wayland;

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

  services.nodeModules.gc = {
    enable = true;
    directories = ["$HOME/Projects"];
    olderThanDays = 14;
    frequency = "weekly";
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
