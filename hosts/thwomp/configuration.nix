# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  inputs,
  ...
}: let
  system = ../../system;
in {
  imports = [
    ./hardware-configuration.nix
    "${system}/core"
    "${system}/shared"
    "${system}/hardware/amd.nix"
    "${system}/hardware/bluetooth.nix"
    "${system}/network"
    "${system}/programs/discord.nix"
    "${system}/programs/fonts.nix"
    "${system}/programs/libre.nix"
    "${system}/programs/plasma.nix"
    "${system}/programs/steam.nix"
    "${system}/services/boot.nix"
    "${system}/services/docker.nix"
    "${system}/services/greetd.nix"
    "${system}/services/openssh.nix"
    "${system}/services/openvpn.nix"
    "${system}/services/pipewire.nix"

    inputs.solaar.nixosModules.default
  ];

  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;
      grub = {
        enable = true;
        efiSupport = true;
        device = "nodev";
        configurationLimit = 8;
      };
    };
  };

  networking.hostName = "thwomp"; # Define your hostname.

  services.xserver.enable = true;

  services.udev.extraRules = ''
    ACTION=="add|change", SUBSYSTEM=="usb", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c547", ATTR{power/wakeup}="disabled"
  '';

  systemd.services."disable-xhc2-wakeup" = {
    description = "disable wakeup from usb controller XHC2";
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = ''/bin/sh -c 'echo XHC2 > /proc/acpi/wakeup' '';
    };
  };

  systemd.services.NetworkManager-wait-online.enable = false;

  hardware.enableAllFirmware = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;

  boot.kernelPatches = [
    {
      name = "btusb-patch";
      patch = ./btusb.patch;
    }
  ];

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
    OZONE_PLATFORM = "wayland";
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    tidal-hifi
    rocmPackages.rocm-smi
    satisfactorymodmanager
  ];

  services.solaar.enable = true;

  hardware.logitech.wireless.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
