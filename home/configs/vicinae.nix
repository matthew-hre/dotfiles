{
  osConfig,
  inputs,
  lib,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.vicinae {
  imports = [
    inputs.vicinae.homeManagerModules.default
  ];

  services.vicinae = {
    enable = true;
    settings = {
      popToRootOnClose = true;
      theme.name = "dracula";
    };
  };
}
