{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.wayland {
  imports = [
    inputs.niri.homeModules.niri

    ./dunst
    ./gtk.nix
    ./hypridle
    ./hyprlock
    ./niri
    ./waybar
  ];

  config = {
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
