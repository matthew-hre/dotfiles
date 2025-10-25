{
  osConfig,
  lib,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.ssh {
  programs.ssh = {
    enable = true;
    extraConfig = "
Host *
  IdentityAgent ~/.1password/agent.sock
    ";
  };
}
