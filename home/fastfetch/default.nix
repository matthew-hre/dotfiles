{
  lib,
  pkgs,
  ...
}: {
  programs.fastfetch = {
    enable = true;
    package = pkgs.fastfetch;

    settings = {
      "$schema" = "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json";
      logo = {
        type = "small";
        color = {
          "1" = "green";
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
          format = "{1}";
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
