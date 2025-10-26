{
  hostname,
  lib,
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
        enableGnomeKeyring = true;
      };

      "polkit-1" = lib.mkIf toad {
        fprintAuth = true;
      };

      greetd.enableGnomeKeyring = true;
      login.enableGnomeKeyring = true;
    };
  };
}
