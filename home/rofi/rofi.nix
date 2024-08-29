{pkgs, ...}: {
  programs.rofi = {
    enable = true;
    location = "center";
    plugins = with pkgs; [
      rofi-calc
      rofi-emoji
      rofi-systemd
    ];
    extraConfig = {
      modi = "drun,emoji";
      font = "sans 28px";
      display-drun = "Applications";
      drun-display-format = "{name}";
      cycle = false;
      normalWindow = true;
    };
    theme = ./index.rasi;
  };
}
