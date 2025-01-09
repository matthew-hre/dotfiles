{
  imports = [
    ../nix
    ./users.nix
    ./security.nix
  ];
  time.timeZone = "America/Edmonton";

  i18n.defaultLocale = "en_CA.UTF-8";
}
