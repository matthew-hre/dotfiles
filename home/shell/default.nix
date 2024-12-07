{...}: {
  imports = [
    ./ghostty.nix
    ./kitty.nix
    ./zellij/default.nix
    ./zsh.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";

    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";

    ZELLIJ_AUTO_ATTACH = "true";
    ZELLIJ_AUTO_EXIT = "true";

    ELECTRON_OZONE_PLATFORM_HINT = "wayland";

    NIXOS_OZONE_WL = "1";
  };
}
