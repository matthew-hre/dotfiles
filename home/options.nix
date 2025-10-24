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
      shell = lib.mkEnableOption "enable shell configuration";
      wayland = lib.mkEnableOption "enable wayland configuration";
    };
  };

  config = lib.mkIf config.users.matthew_hre.enable {
    home-manager.users.matthew_hre = {
      imports = [
        ./configs/bat.nix
        ./configs/btop.nix
        ./configs/direnv.nix
        ./configs/fastfetch
        ./configs/fuzzel.nix
        ./configs/garbage.nix
        ./configs/git.nix
        ./configs/ssh.nix
        ./configs/vicinae.nix
        ./editors/helix
        ./editors/nvf
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
