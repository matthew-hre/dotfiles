{...}: {
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 12;
    };

    keybindings = {
      "ctrl+shift+c" = "copy_to_clipboard";
    };

    settings = {
      copy_on_select = "no";
      enable_audio_bell = "no";
      confirm_os_window_close = 0;
      background_opacity = "0.7";
      background_blur = 2;
      window_padding_width = "8 10";

      wheel_scroll_multiplier = 2;
      touch_scroll_multiplier = 5;

      foreground = "#f8f8f2";
      background = "#282a36";
      selection_foreground = "#ffffff";
      selection_background = "#44475a";

      url_color = "#8be9fd";

      # Black
      color0 = "#21222c";
      color8 = "#6272a4";

      # Red
      color1 = "#ff5555";
      color9 = "#ff6e6e";

      # Green
      color2 = "#50fa7b";
      color10 = "#69ff94";

      # Yellow
      color3 = "#f1fa8c";
      color11 = "#ffffa5";

      # Blue
      color4 = "#bd93f9";
      color12 = "#d6acff";

      # Magenta
      color5 = "#ff79c6";
      color13 = "#ff92df";

      # Cyan
      color6 = "#8be9fd";
      color14 = "#a4ffff";

      # White
      color7 = "#f8f8f2";
      color15 = "#ffffff";

      # Cursor colors
      cursor = "#f8f8f2";
      cursor_text_color = "background";

      # Tab bar colors
      active_tab_foreground = "#282a36";
      active_tab_background = "#f8f8f2";
      inactive_tab_foreground = "#282a36";
      inactive_tab_background = "#6272a4";

      # Marks
      mark1_foreground = "#282a36";
      mark1_background = "#ff5555";

      # Splits/Windows
      active_border_color = "#f8f8f2";
      inactive_border_color = "#6272a4";

    };
  };
}
