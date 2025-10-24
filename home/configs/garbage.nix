{
  config,
  imports,
  lib,
  ...
}: {
  config = lib.mkIf config.users.matthew_hre.configs.garbage {
    imports = [
      inputs.dustpan.homeManagerModules.dustpan
    ];

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
