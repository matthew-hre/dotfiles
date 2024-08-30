{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      import = [pkgs.alacritty-theme.dracula];
      window = {
        opacity = 0.8;
        blur = true;
        dimensions = {
          columns = 169;
          lines = 42;
        };
        padding = {
          x = 4;
          y = 4;
        };
        decorations = "full";
      };
      font = {
        size = 12;
        normal = {
          family = "FiraCode Nerd Font";
          style = "Regular";
        };
        bold = {
          family = "FiraCode Nerd Font";
          style = "Bold";
        };
        italic = {
          family = "FiraCode Nerd Font";
          style = "Italic";
        };
      };
      scrolling.multiplier = 5;
      selection.save_to_clipboard = true;
    };
  };
}
