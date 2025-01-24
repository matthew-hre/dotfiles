{
  inputs,
  lib,
  pkgs,
  ...
}: let
  ghostty = inputs.ghostty.packages.${pkgs.system}.default;

  ghosttyTheme = pkgs.writeTextFile {
    name = "ghostty-theme-Dracula";
    text = ''
      palette = 0=#000000
      palette = 1=#ff5555
      palette = 2=#50fa7b
      palette = 3=#f1fa8c
      palette = 4=#bd93f9
      palette = 5=#ff79c6
      palette = 6=#8be9fd
      palette = 7=#bbbbbb
      palette = 8=#555555
      palette = 9=#ff5555
      palette = 10=#50fa7b
      palette = 11=#f1fa8c
      palette = 12=#bd93f9
      palette = 13=#ff79c6
      palette = 14=#8be9fd
      palette = 15=#ffffff
      background = #282a36
      foreground = #f8f8f2
      cursor-color = #f8f8f2
      cursor-text = #282a36
      selection-background = #44475a
      selection-foreground = #ffffff
    '';
  };
in {
  config = {
    home = {
      packages = [ghostty];
      sessionVariables = {GHOSTTY_RESOURCES_DIR = "${ghostty}/share";};
    };

    xdg.configFile."ghostty/config".text =
      lib.generators.toKeyValue {
        mkKeyValue = lib.generators.mkKeyValueDefault {} " = ";
        listsAsDuplicateKeys = true;
      } {
        background-opacity = 1;
        confirm-close-surface = false;
        copy-on-select = true;
        font-family = "FiraCode Nerd Font";
        font-size = 11;
        font-style = "Medium";
        gtk-wide-tabs = false;

        shell-integration = "none";
        theme = "${ghosttyTheme}";
        unfocused-split-opacity = 0.9;
        window-decoration = false;
        window-padding-x = 16;
        window-padding-y = 16;
        window-padding-balance = true;
        window-theme = "ghostty";
        keybind = ["ctrl+shift+l=new_split:right" "ctrl+shift+d=new_split:down"];
      };
  };
}
