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
        source = "./logo_yoshi.txt";
        color = {
          "1" = "green";
        };
        padding = {
          top = 2;
          left = 4;
          right = 4;
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
        separator = " 󰁔 ";
      };
      modules =
        [
          {
            type = "custom";
            outputColor = "blue";
            format = ''┌──────────── OS Information ────────────┐'';
          }
          {
            type = "title";
            key = " ╭─ ";
            keyColor = "green";
            color = {
              user = "green";
              host = "green";
            };
          }
        ]
        ++ lib.optionals pkgs.stdenv.isDarwin [
          {
            type = "os";
            key = " ├─  ";
            keyColor = "green";
          }
          {
            type = "kernel";
            key = " ├─  ";
            keyColor = "green";
          }
          {
            type = "packages";
            key = " ├─  ";
            keyColor = "green";
          }
        ]
        ++ lib.optionals pkgs.stdenv.isLinux [
          {
            type = "os";
            key = " ├─ ";
            keyColor = "green";
          }
          {
            type = "kernel";
            key = " ├─ ";
            keyColor = "green";
          }
          {
            type = "packages";
            key = " ├─ ";
            keyColor = "green";
          }
        ]
        ++ [
          {
            type = "shell";
            key = " ╰─  ";
            keyColor = "green";
          }
          {
            type = "custom";
            outputColor = "blue";
            format = ''├───────── Hardware Information ─────────┤'';
          }
          {
            type = "display";
            key = " ╭─ 󰍹 ";
            keyColor = "blue";
            compactType = "original-with-refresh-rate";
          }
          {
            type = "cpu";
            key = " ├─ 󰍛 ";
            keyColor = "blue";
          }
          {
            type = "gpu";
            key = " ├─  ";
            keyColor = "blue";
          }
          {
            type = "disk";
            key = " ├─ 󱛟 ";
            keyColor = "blue";
          }
          {
            type = "memory";
            key = " ╰─  ";
            keyColor = "blue";
          }
          {
            type = "custom";
            outputColor = "blue";
            format = ''├───────── Software Information ─────────┤'';
          }
          {
            type = "wm";
            key = " ╭─  ";
            keyColor = "yellow";
          }
          {
            type = "terminal";
            key = " ├─  ";
            keyColor = "yellow";
          }
          {
            type = "font";
            key = " ╰─  ";
            keyColor = "yellow";
          }
          {
            type = "custom";
            outputColor = "blue";
            format = ''├───────── Network Information ─────────┤'';
          }
          {
            type = "localip";
            key = " ╭─ 󰀂 ";
            showIpv4 = true;
            keyColor = "white";
          }
          {
            type = "publicip";
            key = " ╰─  ";
            keyColor = "white";
          }
          {
            type = "custom";
            outputColor = "blue";
            format = ''└────────────────────────────────────────┘'';
          }

          "break"
        ];
    };
  };
}
