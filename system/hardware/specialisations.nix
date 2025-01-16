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
        services.greetd.settings.default_session.command = lib.mkDefault "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --cmd niri --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";

        services.desktopManager.plasma6.enable = lib.mkDefault false;
      };
    };
  };
}
