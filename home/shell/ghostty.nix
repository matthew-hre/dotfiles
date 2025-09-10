{
  inputs,
  lib,
  pkgs,
  ...
}: let
  ghostty = inputs.ghostty.packages.${pkgs.system}.default;
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
        confirm-close-surface = false;
        font-family = "FiraCode Nerd Font";
        font-size = 11;
        font-style = "Medium";
        gtk-wide-tabs = false;

        shell-integration = "fish";
        window-inherit-working-directory = true;
        theme = "Dracula";
        window-decoration = true;
        window-theme = "ghostty";
        window-padding-x = 16;
        window-padding-y = 16;
        window-padding-balance = true;
        keybind = ["ctrl+shift+l=new_split:right" "ctrl+shift+d=new_split:down"];
      };
  };
}
