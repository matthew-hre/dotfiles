{
  inputs,
  pkgs,
  ...
}: {
  home.packages = [
    inputs.quickshell.packages.${pkgs.system}.default
    pkgs.qt6Packages.qt5compat
    pkgs.libsForQt5.qt5.qtgraphicaleffects
    pkgs.kdePackages.qtbase
    pkgs.kdePackages.qtdeclarative
    pkgs.kdePackages.qtstyleplugin-kvantum
    pkgs.wallust
    pkgs.material-symbols
    pkgs.material-icons
    pkgs.cava
    pkgs.gpu-screen-recorder
  ];
}
