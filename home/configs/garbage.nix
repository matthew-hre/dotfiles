{
  osConfig,
  inputs,
  lib,
  ...
}: {
  imports = lib.optionals osConfig.users.matthew_hre.configs.garbage [
    inputs.dustpan.homeManagerModules.dustpan
  ];

  config = lib.mkIf osConfig.users.matthew_hre.configs.garbage {
    nix = {
      gc = {
        automatic = true;
        dates = "monthly";
      };
    };

    services.dustpan = {
      enable = true;
      roots = ["$HOME/Projects"];
      targets = ["node_modules" ".next" ".zig-cache"];
      olderThanDays = 14;
      frequency = "weekly";
    };
  };
}
