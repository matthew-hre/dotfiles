{
  osConfig,
  lib,
  ...
}: {
  imports = lib.optionals osConfig.users.matthew_hre.configs.shell [
    ./fish.nix
    ./ghostty.nix
  ];

  config = lib.mkIf osConfig.users.matthew_hre.configs.shell {
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
