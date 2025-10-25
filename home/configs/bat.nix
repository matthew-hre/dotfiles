{
  osConfig,
  lib,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.bat {
  programs.bat = {
    enable = true;
    config = {
      theme = "Dracula";
    };
  };
}
