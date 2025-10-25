{
  config,
  lib,
  ...
}: let
  cfg = config.services.hibernation;
in {
  options.services.hibernation = {
    enable = lib.mkEnableOption "hibernation support";

    swapDeviceUUID = lib.mkOption {
      type = lib.types.str;
      description = "UUID of the swap device for hibernation";
    };

    lidAction = lib.mkOption {
      type = lib.types.enum ["hibernate" "suspend" "suspend-then-hibernate" "ignore"];
      default = "suspend-then-hibernate";
      description = "action to take when laptop lid is closed";
    };

    hibernateDelay = lib.mkOption {
      type = lib.types.str;
      default = "30m";
      description = "delay before hibernating after suspend";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = ["resume=UUID=${cfg.swapDeviceUUID}"];
    boot.resumeDevice = "/dev/disk/by-uuid/${cfg.swapDeviceUUID}";

    powerManagement.enable = true;

    services.logind.settings.Login = {
      HandleLidSwitch = cfg.lidAction;
      HandleLidSwitchDocked = "ignore";
      HandlePowerKey = "hibernate";
    };

    systemd.sleep.extraConfig = ''
      HibernateDelaySec=${cfg.hibernateDelay}
    '';
  };
}
