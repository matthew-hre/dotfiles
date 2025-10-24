{
  osConfig,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.users.matthew_hre.configs.btop {
    programs.btop = {
      enable = true;
      package = pkgs.btop.overrideAttrs (old: rec {
        buildInputs = (old.buildInputs or []) ++ [pkgs.rocmPackages.rocm-smi];
        postFixup = lib.concatStringsSep "\n" [
          (old.postFixup or "")
          ''
            patchelf --add-rpath ${lib.getLib pkgs.rocmPackages.rocm-smi}/lib \
              $out/bin/btop
          ''
        ];
      });

      settings = {
        color_theme = "Dracula";
        theme_background = false;
        selected_gpus = "0";
      };
    };
  };
}
