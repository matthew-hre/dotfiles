{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}: {
  imports = lib.optionals osConfig.users.matthew_hre.configs.wayland [
    inputs.niri.homeModules.niri

    ./dunst
    ./gtk.nix
    ./hypridle
    ./hyprlock
    ./niri
    ./waybar
  ];

  config = lib.mkIf osConfig.users.matthew_hre.configs.wayland {
    home.packages = with pkgs; [
      amberol
      (celluloid.override {youtubeSupport = true;})
      file-roller
      loupe
      nautilus
      pwvucontrol

      wl-clipboard
      cliphist
      hyprpicker

      networkmanagerapplet
      brightnessctl

      xwayland-satellite

      nmgui
    ];

    services.wlsunset = {
      enable = true;
      latitude = 51;
      longitude = -114;
    };
  };
}
