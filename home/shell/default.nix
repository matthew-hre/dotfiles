{
  osConfig,
  lib,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.shell {
  imports = [
    ./fish.nix
    ./ghostty.nix
  ];

  config = {
    home.sessionVariables = {
      EDITOR = "nvim";
      BROWSER = "firefox";
      TERMINAL = "kitty";

      DELTA_PAGER = "less -R";

      MANPAGER = "sh -c 'col -bx | bat -l man -p'";
      MANROFFOPT = "-c";
    };
  };
}
