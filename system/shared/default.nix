{lib, ...}: {
  imports = [
    ./programs.nix
    ./services.nix
    ./packages.nix
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";

    # ELECTRON_OZONE_PLATFORM_HINT can be overridden per host
    # mainly due to some kde issues
    ELECTRON_OZONE_PLATFORM_HINT = lib.mkDefault "wayland";
  };
}
