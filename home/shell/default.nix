{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.users.matthew_hre.configs.shell;
in
  lib.optionalAttrs cfg.enable {
    imports =
      lib.optional cfg.fish ./fish.nix
      ++ lib.optional cfg.ghostty ./ghostty.nix;

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
