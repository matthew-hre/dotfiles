{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.users.matthew_hre.configs.bat {
    programs.bat = {
      enable = true;
      config = {
        theme = "Dracula";
      };
    };
  };
}
