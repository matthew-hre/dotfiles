{
  config,
  pkgs,
  ...
}: let
  makeCommand = command: {
    command = [command];
  };
in {
  home.packages = with pkgs; [
    grim
    slurp

    wl-clipboard
    hyprpicker

    networkmanagerapplet
    brightnessctl
  ];

  programs.niri = {
    enable = true;
    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = ":0";
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      };

      spawn-at-startup = [
        (makeCommand "swww-daemon")
        (makeCommand "kwalletd6")
        (makeCommand "kded6")
        (makeCommand "${pkgs.polkit-kde-agent}")
        (makeCommand "NetworkManager")
        (makeCommand "wl-paste --type image --watch cliphist store")
        (makeCommand "wl-paste --type text --watch cliphist store")
        (makeCommand "waybar")
        (makeCommand "hyprlock")
        (makeCommand "ghostty")
      ];

      cursor = {
        theme = "BreezeX-Dark";
        size = 20;
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };

      binds = with config.lib.niri.actions; {
        "Mod+Space".action.spawn = ["fuzzel"];
        "Mod+Return".action.spawn = ["ghostty"];
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+G".action = toggle-window-floating;

        "Mod+L".action.spawn = ["hyprlock"];

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-window-down;
        "Mod+Up".action = focus-window-up;
        "Mod+Right".action = focus-column-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;

        "Mod+Shift+S".action = screenshot;
        "Print".action = screenshot;
        "Ctrl+Print".action = screenshot-screen;
        "Alt+Print".action = screenshot-window;

        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "--limit" "1.0"];
        "XF86AudioRaiseVolume".allow-when-locked = true;
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        "XF86AudioLowerVolume".allow-when-locked = true;
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMute".allow-when-locked = true;
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86AudioMicMute".allow-when-locked = true;
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "10%-"];
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "10%+"];

        "Mod+1".action = focus-workspace 1;
        "Mod+2".action = focus-workspace 2;
        "Mod+3".action = focus-workspace 3;
        "Mod+4".action = focus-workspace 4;
        "Mod+5".action = focus-workspace 5;
        "Mod+6".action = focus-workspace 6;
        "Mod+7".action = focus-workspace 7;
        "Mod+8".action = focus-workspace 8;
        "Mod+9".action = focus-workspace 9;
        "Mod+Shift+1".action = move-column-to-workspace 1;
        "Mod+Shift+2".action = move-column-to-workspace 2;
        "Mod+Shift+3".action = move-column-to-workspace 3;
        "Mod+Shift+4".action = move-column-to-workspace 4;
        "Mod+Shift+5".action = move-column-to-workspace 5;
        "Mod+Shift+6".action = move-column-to-workspace 6;
        "Mod+Shift+7".action = move-column-to-workspace 7;
        "Mod+Shift+8".action = move-column-to-workspace 8;
        "Mod+Shift+9".action = move-column-to-workspace 9;
      };

      switch-events = {
        lid-close.action.spawn = ["hyprlock"];
      };

      prefer-no-csd = true;

      layout = {
        gaps = 8;
        center-focused-column = "always";

        focus-ring = {
          enable = false;
          width = 1;
          active.color = "#BD93F9";
          inactive.color = "#282A36";
        };

        border = {
          enable = true;
          width = 1;
          active.color = "#BD93F9";
          inactive.color = "#282A36";
        };
      };

      window-rules = [
        (let
          allCorners = r: {
            bottom-left = r;
            bottom-right = r;
            top-left = r;
            top-right = r;
          };
        in {
          geometry-corner-radius = allCorners 10.0;
          clip-to-geometry = true;
          draw-border-with-background = false;
        })
      ];
    };
  };
}
