<<<<<<< HEAD
{ pkgs, lib, ... }:

=======
{ pkgs, ... }:
>>>>>>> f23fdfd (take 2)
{
  wayland.windowManager.hyprland = {
    enable = true;

<<<<<<< HEAD
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
=======
    package = pkgs.hyprland;

    xwayland.enable = true;

    systemd.enable = true;

    settings = {
      monitor = [
        "HDMI-A-1,2560x1440,0x0,1"
        "eDP-1,2560x1440,2560x288,1.25"
        ", preferred, auto, 1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      input = {
        follow_mouse = 0;
        touchpad = {
          natural_scroll = true;
          scroll_factor = 0.2;
        };

        sensitivity = 0;
      };

      exec-once = [
        "hyprctl setcursor Bibata-Modern-Classic 24"
        "pkill waybar & sleep 0.5 && waybar"
        "hyprpaper"
        "dunst"
      ];

      windowrule = [
        "float, ^(Rofi)$"
      ];

      general = {
        "col.active_border" = "rgb(44475a) rgb(bd93f9) 90deg";
        "col.inactive_border" = "rgba(44475aaa)";
        "col.nogroup_border" = "rgba(282a36dd)";
        "col.nogroup_border_active" = "rgb(bd93f9) rgb(44475a) 90deg";
        no_border_on_floating = false;
        border_size = 2;
      };

      decoration = {
        "col.shadow" = "rgba(1E202966)";

        drop_shadow = true;
        shadow_range = 60;
        shadow_offset = "1 2";
        shadow_render_power = 3;
        shadow_scale = 0.97;
      };

      group = {
        groupbar = {
          "col.active" = "rgb(bd93f9) rgb(44475a) 90deg";
          "col.inactive" = "rgba(282a36dd)";
        };
      };

      animations = {
        enabled = true;
      };

      gestures = {
        workspace_swipe = true;
      };

>>>>>>> f23fdfd (take 2)
      "$mod" = "SUPER";

      bind = [
        "$mod, RETURN, exec, alacritty"
<<<<<<< HEAD
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

=======
        "$mod, SPACE, exec, rofi -show drun -normal-window"
        "$mod, Q, killactive"
        "$mod, F, togglefloating"
        "$mod, G, fullscreen"

        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"

        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"

        "ALT,Tab,cyclenext,"
        "ALT,Tab,bringactivetotop,"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
        "$mod ALT, mouse:272, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ];
    };
  };

  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.bibata-cursors;
    name = "Bibata-Modern-Classic";
    size = 25;
  };

  home.packages = [ pkgs.dconf pkgs.xdg-utils ];

  gtk = {
    enable = true;
    theme = {
      name = "Dracula";
      package = pkgs.dracula-theme;
    };
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    cursorTheme = {
      name = "Bibata-Modern-Classic";
      package = pkgs.bibata-cursors;
    };

    gtk3.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };

    gtk4.extraConfig = {
      Settings = ''
        gtk-application-prefer-dark-theme=1
        gtk-cursor-theme-name=Bibata-Modern-Classic
      '';
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-wlr
      pkgs.xdg-desktop-portal-hyprland
    ];
    config.common.default = "*";
>>>>>>> f23fdfd (take 2)
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
<<<<<<< HEAD
        "/home/matthew_hre/Pictures/wallpaper.png"
      ];

      wallpaper = [
        "eDP-1,/home/matthew_hre/Pictures/wallpaper.png"
      ];
    };
  };
=======
        "~/Pictures/wallpaper.png"
      ];

      wallpaper = [
        "HDMI-A-1,~/Pictures/wallpaper.png"
        "eDP-1,~/Pictures/wallpaper.png"
      ];
    };
  };

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Papirus-Dark";
      package = pkgs.papirus-icon-theme;
    };
    settings = {
      global = {
        origin = "top-right";
        alignment = "left";
        width = "400";
        height = "400";
        offset = "10x50";
        scale = 0;
        notification_limit = 0;
        gap_size = 0;
        progress_bar = true;
        transparency = 15;
        text_icon_padding = 0;
        frame_width = 0;
        frame_color = "#282a36";
        separator_color = "frame";
        sort = "yes";
        font = "FiraCode Nerd Font 12";
        markup = "full";
        line_height = 0;
        format = "%s %p\n%b";
        vertical_alignment = "center";
        show_age_threshold = 60;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        icon_position = "left";
      };
      urgency_low = {
        background = "#282a36";
        foreground = "#6272a4";
        timeout = 10;
      };
      urgency_normal = {
        background = "#282a36";
        foreground = "#bd93f9";
        timeout = 10;
      };
      urgency_critical = {
        background = "#ff5555";
        foreground = "#f8f8f2";
        frame_color = "#ff5555";
        timeout = 0;
      };
    };
  };
>>>>>>> f23fdfd (take 2)
}
