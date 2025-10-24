{
  inputs,
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.users.matthew_hre.configs.wayland;
in
  lib.optionalAttrs cfg.enable {
    imports =
      lib.optional cfg.niri inputs.niri.homeModules.niri
      ++ lib.optional cfg.dunst ./dunst
      ++ lib.optional cfg.gtk ./gtk
      ++ lib.optional cfg.hypridle ./hypridle
      ++ lib.optional cfg.hyprlock ./hyprlock
      ++ lib.optional cfg.niri ./niri
      ++ lib.optional cfg.waybar ./waybar
      ++ lib.optional cfg.wlsunset ./wlsunset;

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
    };
  }
