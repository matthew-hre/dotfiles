{ pkgs, lib, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;

    xwayland.enable = true;
    package = pkgs.hyprland;
    systemd.enable = true;

    extraConfig = ''
      monitor = eDP-1, 2560x1440, 2560x0, 1.25
      monitor = HDMI-A-1, 2560x1440, 0x0, 1

      exec-once = hyprctl setcursor Bibata-Modern-Classic 24
      exec-once = nm-applet &
      exec-once = hyprpaper

      bindel = ,XF86AudioRaiseVolume, exec, wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+
      bindel = ,XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
      bindel = ,XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
      bindel = ,XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle
      bindel = ,XF86MonBrightnessUp, exec, brightnessctl s 10%+
      bindel = ,XF86MonBrightnessDown, exec, brightnessctl s 10%-

      windowrulev2 = float,class:^(Rofi)$
    '';

    settings = {
      "$mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, alacritty"
        "$mod, SPACE, exec, rofi -show drun"
        "$mod, F, toggleFloating, "
        "ALT, F4, killactive"
      ];

      bindm = [ 
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      misc = {
        force_default_wallpaper = 0;
        disable_hyprland_logo = true;
      };

      decoration = {
        active_opacity = 0.8;
        inactive_opacity = 0.7;

        blur = {
          enabled = true;
          size = 3;
          passes = 1;

          vibrancy = 0.1696;
        };
      };

      input = {
        follow_mouse = 1;
        sensitivity = 0;

        touchpad = {
          natural_scroll = false;
        };
      };
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;

    settings = {
      mainBar = {
        layer =  "top";
        position = "top";
        height = 26;

        modules-left = [ "custom/logo" "sway/workspaces" "sway/mode" ];
        modules-right = [ "clock" "battery" ];

        "custom/logo" = {
          format = "";
          tooltip = false;
          on-click = ''rofi -show drun'';
        };

        "sway/mode" = {
          tooltip = false;
        };

        "clock" = {
          interval = 60;
          format = "{%A, %-d %B, %Y ─ %-I:%M%p}";
        };

        "battery" = {
          tooltip = false;
        };
      };
    };

    style = ''
      * {
        border: none;
        border-radius: 0;
        padding: 0;
        margin: 0;
        font-size: 11px; 
      }

      window#waybar {
        background: #282A36;
        color: #F8F8F2;
      }

      #custom-logo {
        font-size: 18px;
        margin: 0;
        margin-left: 7px;
        margin-right: 12px;
        padding: 0;
        font-family: FiraCode Nerd Font Mono;
      }
    '';

  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "/home/matthew_hre/Pictures/wallpaper.png"
      ];

      wallpaper = [
        "eDP-1,/home/matthew_hre/Pictures/wallpaper.png"
      ];
    };
  };
}
