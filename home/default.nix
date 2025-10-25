{
  config,
  lib,
  pkgs,
  ...
}: {
  options.users.matthew_hre = {
    enable = lib.mkEnableOption "enable user config";

    packages = lib.mkOption {
      description = "list of packages to install";
      type = lib.types.listOf lib.types.package;
      default = [];
    };

    configs = {
      bat = lib.mkEnableOption "enable bat configuration";
      btop = lib.mkEnableOption "enable btop configuration";
      direnv = lib.mkEnableOption "enable direnv configuration";
      fastfetch = lib.mkEnableOption "enable fastfetch configuration";
      fuzzel = lib.mkEnableOption "enable fuzzel configuration";
      garbage = lib.mkEnableOption "enable garbage configuration";
      git = lib.mkEnableOption "enable git configuration";
      ssh = lib.mkEnableOption "enable ssh configuration";
      vicinae = lib.mkEnableOption "enable vicinae configuration";
      helix = lib.mkEnableOption "enable helix configuration";
      nvf = lib.mkEnableOption "enable nvf (neovim) configuration";

      shell = {
        enable = lib.mkEnableOption "enable shell configuration";
        fish = lib.mkEnableOption "enable fish shell configuration";
        ghostty = lib.mkEnableOption "enable ghostty terminal configuration";
      };

      wayland = {
        enable = lib.mkEnableOption "enable wayland configuration";
        dunst = lib.mkEnableOption "enable dunst notification daemon";
        gtk = lib.mkEnableOption "enable gtk configuration";
        hypridle = lib.mkEnableOption "enable hypridle configuration";
        hyprlock = lib.mkEnableOption "enable hyprlock configuration";
        niri = lib.mkEnableOption "enable niri window manager";
        waybar = lib.mkEnableOption "enable waybar configuration";
        wlsunset = lib.mkEnableOption "enable wlsunset (blue light filter)";
      };
    };
  };

  config = lib.mkIf config.users.matthew_hre.enable {
    users.users.matthew_hre = {
      isNormalUser = true;
      home = "/home/matthew_hre";
      description = "Matthew Hrehirchuk";
      extraGroups = ["wheel" "networkmanager" "docker" "wireshark"];
      shell = pkgs.fish;
    };

    users.defaultUserShell = pkgs.fish;

    home-manager.users.matthew_hre = {
      imports = [
        ./configs
        ./editors
        ./shell
        ./wayland
      ];

      home = {
        username = "matthew_hre";
        homeDirectory = "/home/matthew_hre";
        stateVersion = "23.11";

        packages = with pkgs;
          [
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
            wireshark
          ]
          ++ config.users.matthew_hre.packages;

        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";
          XDG_SESSION_TYPE = "wayland";
        };
      };

      programs.vscode.enable = true;

      programs.home-manager.enable = true;
    };
  };
}
