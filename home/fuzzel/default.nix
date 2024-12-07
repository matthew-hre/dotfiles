{...}: {
  programs.fuzzel = {
    enable = true;
    settings = {
      main = {
        width = 40;
        lines = 8;
        line-height = 30;
        icon-theme = "Papirus";
        prompt = ''"  "'';
        font = "FiraCode Nerd Font:size=14";
        horizontal-pad = 20;
        vertical-pad = 0;
        inner-pad = 0;
      };
      colors = {
        background = "282A36b2";
        text = "f8f8f2ff";
        match = "8be9fdff";
        selection-match = "8be9fdff";
        selection = "BD93F9dd";
        selection-text = "282A36ff";
        border = "bd93f9ff";
      };
    };
  };
}
