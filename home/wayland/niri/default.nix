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
    wl-clipboard
    cliphist
    hyprpicker

    networkmanagerapplet
    brightnessctl

    xwayland-satellite
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
        SDL_VIDEODRIVER = "wayland";
      };

      spawn-at-startup = [
        (makeCommand "swww-daemon")
        (makeCommand "kwalletd6")
        (makeCommand "kded6")
        (makeCommand "${pkgs.kdePackages.polkit-kde-agent-1}")
        (makeCommand "NetworkManager")
        (makeCommand "waybar")
        (makeCommand "hyprlock")
        (makeCommand "ghostty")
        (makeCommand "xwayland-satellite")
        {command = ["wl-paste" "--watch" "cliphist" "store"];}
      ];

      cursor = {
        theme = "BreezeX-Dark";
        size = 24;
      };

      hotkey-overlay = {
        skip-at-startup = true;
      };

      # outputs."eDP-1" = {
      # enable = true;
      # mode = {
      #   refresh = 60.001;
      #   width = 2880;
      #   height = 1920;
      # };
      # };

      binds = with config.lib.niri.actions; let
        sh = spawn "sh" "-c";
      in {
        "Mod+Space".action.spawn = ["fuzzel"];
        "Mod+Return".action.spawn = ["ghostty"];
        "Mod+Q".action = close-window;
        "Mod+F".action = maximize-column;
        "Mod+Shift+F".action = fullscreen-window;
        "Mod+G".action = toggle-window-floating;
        "Mod+C".action = center-column;
        "Mod+V".action = sh "cliphist list | fuzzel --dmenu | cliphist decode | wl-copy";

        "Mod+L".action.spawn = ["hyprlock"];

        "Mod+Minus".action = set-column-width "-10%";
        "Mod+Equal".action = set-column-width "+10%";

        "Mod+Shift+Minus".action = set-window-height "-10%";
        "Mod+Shift+Equal".action = set-window-height "+10%";

        "Mod+Left".action = focus-column-left;
        "Mod+Down".action = focus-workspace-down;
        "Mod+Up".action = focus-workspace-up;
        "Mod+Right".action = focus-column-right;

        "Mod+Shift+Left".action = move-column-left;
        "Mod+Shift+Down".action = move-window-down;
        "Mod+Shift+Up".action = move-window-up;
        "Mod+Shift+Right".action = move-column-right;

        "Mod+Shift+Ctrl+Left".action = consume-or-expel-window-left;
        "Mod+Shift+Ctrl+Right".action = consume-or-expel-window-right;

        "Mod+Shift+S".action = screenshot;
        "Print".action = screenshot;
        "Alt+Print".action = screenshot-window;

        "Mod+Shift+Slash".action = show-hotkey-overlay;

        "Ctrl+Alt+Delete".action.spawn = ["~/nix-config/scripts/fuzzel_power.sh"];

        "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1+" "--limit" "1.0"];
        "XF86AudioRaiseVolume".allow-when-locked = true;
        "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "0.1-"];
        "XF86AudioLowerVolume".allow-when-locked = true;
        "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];
        "XF86AudioMute".allow-when-locked = true;
        "XF86AudioMicMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle"];
        "XF86AudioMicMute".allow-when-locked = true;
        "XF86MonBrightnessDown".action.spawn = ["brightnessctl" "set" "5%-"];
        "XF86MonBrightnessUp".action.spawn = ["brightnessctl" "set" "5%+"];

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
        center-focused-column = "never";

        default-column-width.proportion = 1.0;

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

      animations.shaders.window-resize = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;

          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          // We can crop if the current window size is smaller than the next window
          // size. One way to tell is by comparing to 1.0 the X and Y scaling
          // coefficients in the current-to-next transformation matrix.
          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x)
              coords.x = coords_crop.x;
          if (can_crop_by_y)
              coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          // However, when we crop, we also want to crop out anything outside the
          // current geometry. This is because the area of the shader is unspecified
          // and usually bigger than the current geometry, so if we don't fill pixels
          // outside with transparency, the texture will leak out.
          //
          // When stretching, this is not an issue because the area outside will
          // correspond to client-side decoration shadows, which are already supposed
          // to be outside.
          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
              color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
              color = vec4(0.0);

          return color;
        }
      '';

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
