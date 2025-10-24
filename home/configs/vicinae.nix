{
  osConfig,
  inputs,
  lib,
  ...
}: {
  imports = lib.optionals osConfig.users.matthew_hre.configs.vicinae [
    inputs.vicinae.homeManagerModules.default
  ];

  config = lib.mkIf osConfig.users.matthew_hre.configs.vicinae {
    services.vicinae = {
      enable = true;
      settings = {
        popToRootOnClose = true;
        theme.name = "dracula";
      };
    };
  };
}
