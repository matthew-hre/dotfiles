{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    swww # needs to be installed at the system level
    qt6Packages.qt5compat
    libsForQt5.qt5.qtgraphicaleffects
    kdePackages.qtbase
    kdePackages.qtdeclarative
    kdePackages.qtstyleplugin-kvantum
    wallust
  ];

  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # shoutout @CodedNil on gh for the fix
  # waiting on https://github.com/YaLTeR/niri/pull/1923 for a real fix
  services.keyd = {
    enable = true;
    keyboards.default = {
      ids = ["*"];
      settings.global = {
        overload_tap_timeout = 200; #ms
      };
      settings.main = {
        compose = "layer(meta)";
        leftmeta = "overload(meta, macro(leftmeta+z))";
      };
    };
  };

  # turns out i've been using this the whole time!
  # i believe niri uses this automatically, but it doesn't hurt to set it
  services.gnome.gnome-keyring.enable = true;
}
