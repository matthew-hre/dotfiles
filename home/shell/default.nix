{...}: {
  imports = [
    ./fish.nix
    ./ghostty.nix
    ./kitty.nix
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "kitty";

    DELTA_PAGER = "less -R";

    MANPAGER = "sh -c 'col -bx | bat -l man -p'";
    MANROFFOPT = "-c";
  };
}
