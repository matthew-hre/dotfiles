{ inputs, lib, pkgs, ... }:
let
  ghostty = inputs.ghostty.packages.${pkgs.system}.default;

  ghosttyTheme = pkgs.writeTextFile {
    name = "ghostty-theme-Dracula";
    text = builtins.readFile "${ghostty}/share/ghostty/themes/Dracula";
  };
in {
  config = {
    home = {
      packages = [ ghostty ];
      sessionVariables = { GHOSTTY_RESOURCES_DIR = "${ghostty}/share"; };
    };

    xdg.configFile."ghostty/config".text = lib.generators.toKeyValue {
      mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
      listsAsDuplicateKeys = true;
    } {
      background-opacity = 0.7;
      confirm-close-surface = false;
      copy-on-select = true;
      font-family = "FiraCode Nerd Font";
      font-size = 11;
      font-style = "Medium";
      gtk-wide-tabs = false;

      minimum-contrast = 1.1;
      shell-integration = "none";
      theme = "${ghosttyTheme}";
      unfocused-split-opacity = 0.9;
      window-decoration = false;
      window-padding-x = 16;
      window-padding-y = 16;
      window-padding-balance = true;
      window-theme = "ghostty";
      keybind =
        [ "ctrl+shift+l=new_split:right" "ctrl+shift+d=new_split:down" ];
    };
  };
}
