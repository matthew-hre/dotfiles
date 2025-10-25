{
  osConfig,
  lib,
  pkgs,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.fastfetch {
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        source = "/home/matthew_hre/nix-config/home/fastfetch/logo_nix.txt";
        color = {
          "1" = "blue";
        };
        padding = {
          top = 1;
        };
      };
      display = {
        color = {
          keys = "green";
          title = "blue";
        };
        percent = {
          type = 9;
        };
        separator = " ";
      };
      modules = [
        {
          type = "title";
          format = " ";
        }
        {
          type = "title";
          format = "{user-name-colored}{at-symbol-colored}{host-name-colored}";
        }
        {
          type = "os";
          key = "os     ";
          format = "{3}";
          keyColor = "green";
        }
        {
          type = "host";
          key = "host   ";
          format = "{0}";
          keyColor = "green";
        }
        {
          type = "kernel";
          key = "kernel ";
          keyColor = "green";
        }
        {
          type = "uptime";
          key = "uptime ";
          keyColor = "green";
        }
        {
          type = "packages";
          key = "pkgs   ";
          keyColor = "green";
        }
        {
          type = "memory";
          key = "memory ";
          keyColor = "green";
        }
      ];
    };
  };
}
