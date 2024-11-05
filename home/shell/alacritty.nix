{pkgs, ...}: {
  programs.alacritty = {
    enable = true;
    settings = {
      env.TERM = "xterm-256color";
      import = [pkgs.alacritty-theme.dracula]; # remove later, rolled back for fix
      # general.import = [pkgs.alacritty-theme.dracula];
      window = {
        opacity = 0.7;
        blur = true;
        dimensions = {
          columns = 192;
          lines = 50;
        };
        padding = {
          x = 16;
          y = 16;
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
