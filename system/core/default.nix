{
  imports = [
    ../nix
    ./security.nix
  ];
  time.timeZone = "America/Edmonton";

  services.journald.extraConfig = "SystemMaxUse=1G";

  i18n.defaultLocale = "en_CA.UTF-8";
}
