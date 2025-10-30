{
  config,
  lib,
  pkgs,
  ...
}: let
  lock = "${pkgs.systemd}/bin/loginctl lock-session";

  # timeout after which DPMS kicks in
  timeout = 300;
in {
  options.home.wayland.hypridle = {
    enable = lib.mkEnableOption "hypridle configuration";
  };

  config = lib.mkIf config.home.wayland.hypridle.enable {
    services.hypridle = {
      enable = true;

      settings = {
        general.lock_cmd = lib.getExe config.programs.hyprlock.package;

        listener = [
          {
            timeout = timeout - 10;
            on-timeout = "brightnessctl -s set 1";

            on-resume = "brightnessctl -r";
          }
          {
            inherit timeout;
          }
          {
            timeout = timeout + 10;
            on-timeout = lock;
          }
          # using system-level suspend-then-hibernate via logind
        ];
      };
    };
  };
}
