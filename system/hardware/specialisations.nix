{
  lib,
  pkgs,
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
          package = pkgs.niri;
        };

        services.desktopManager.plasma6.enable = lib.mkDefault false;
      };
    };
  };
}
