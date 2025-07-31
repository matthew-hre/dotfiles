{
  hostname,
  lib,
  pkgs,
  ...
}: let
  toad = hostname == "toad";
in {
  security = {
    sudo.enable = true;
    rtkit.enable = true;

    pam.services = {
      hyprlock = {
        text = lib.mkIf toad "auth include login";
        kwallet = {
          enable = true;
          package = pkgs.kdePackages.kwallet-pam;
        };
      };

      greetd.kwallet = {
        enable = true;
        package = pkgs.kdePackages.kwallet-pam;
        forceRun = true;
      };
    };
  };
}
