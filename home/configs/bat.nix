{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.users.matthew_hre.configs.bat {
    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
