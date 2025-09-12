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
      inputs.dustpan.homeManagerModules.dustpan
      inputs.vicinae.homeManagerModules.default

      ./bat.nix
      ./btop.nix
      ./fastfetch
      ./fuzzel.nix
      # ./fzf.nix
      ./git.nix
      ./helix.nix
      ./shell
      ./nvf
      ./direnv.nix
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
    fd

    television

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

    xclip
  ];

  home.sessionVariables = {
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  programs.vscode.enable = true;

  programs.ssh = {
    enable = true;
    extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
    ";
  };

  services.vicinae.enable = true;

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
      dates = "monthly";
    };
  };

  services.dustpan = {
    enable = true;
    roots = ["$HOME/Projects"];
    targets = ["node_modules" ".next"];
    olderThanDays = 14;
    frequency = "weekly";
  };

  # Let home Manager install and manage itself.
  programs.home-manager.enable = true;
}
