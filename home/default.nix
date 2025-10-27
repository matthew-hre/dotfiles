{
  config,
  lib,
  pkgs,
  ...
}: {
  config = {
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

        packages = with pkgs; [
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
        ];

        sessionVariables = {
          QT_QPA_PLATFORM = "wayland";
          SDL_VIDEODRIVER = "wayland";
          XDG_SESSION_TYPE = "wayland";
          EDITOR = "nvim";
          BROWSER = "firefox";
          TERMINAL = "ghostty";

          DELTA_PAGER = "less -R";

          MANPAGER = "sh -c 'col -bx | bat -l man -p'";
          MANROFFOPT = "-c";
        };
      };

      programs.home-manager.enable = true;
    };
  };
}
