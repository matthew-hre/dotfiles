{
  osConfig,
  lib,
  ...
}: {
  config =
    lib.mkIf osConfig.users.matthew_hre.configs.ssh {
      programs.ssh = {
        enable = true;
        extraConfig = "
  Host *
    IdentityAgent ~/.1password/agent.sock
      ";
      };
    };
}
