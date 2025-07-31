# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
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
    "${system}/services/docker.nix"
    "${system}/services/greetd.nix"
    "${system}/services/openssh.nix"
    "${system}/services/openvpn.nix"
    "${system}/services/pipewire.nix"
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
        configurationLimit = 5;
      };
    };
  };

  networking.hostName = "thwomp"; # Define your hostname.

  services.xserver.enable = true;

  systemd.services.NetworkManager-wait-online.enable = false;

  boot.kernelPatches = [
    {
      name = "btusb-patch";
      patch = ./btusb.patch;
    }
  ];

  environment.sessionVariables = {
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  environment.systemPackages = with pkgs; [
    prismlauncher
    protonup-qt
    tidal-hifi
  ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
