{
  lib,
  pkgs,
  inputs,
  ...
}: {
  specialisation = {
    niri = {
      configuration = {
        environment.systemPackages = [
          pkgs.swww
        ];

        programs.niri = {
          enable = true;
          package = pkgs.niri-unstable; # trying overview
        };

        services.desktopManager.plasma6.enable = lib.mkDefault false;
      };
    };
  };
}
