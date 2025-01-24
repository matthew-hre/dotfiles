{pkgs, ...}: let
  system = ../../system;
in {
  imports = [
    ./hardware-configuration.nix
    "${system}/core"
    "${system}/hardware/bluetooth.nix"
    "${system}/hardware/nvidia.nix"
    "${system}/network"
    "${system}/programs/discord.nix"
    "${system}/programs/fonts.nix"
    "${system}/programs/libre.nix"
    "${system}/programs/plasma.nix"
    "${system}/programs/steam.nix"
    "${system}/services/greetd.nix"
    "${system}/services/openssh.nix"
    "${system}/services/openvpn.nix"
    "${system}/services/pipewire.nix"
    "${system}/services/power.nix"
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.efiSysMountPoint = "/boot/efi";
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        extraEntries = ''
          menuentry 'Windows Boot Manager (on /dev/nvme1n1p1)' --class windows --class os $menuentry_id_option 'osprober-efi-74E9-4770' {
            insmod part_gpt
            insmod fat
            search --no-floppy --fs-uuid --set=root 74E9-4770
            chainloader /efi/Microsoft/Boot/bootmgfw.efi
          }
        '';
      };
    };
    supportedFilesystems = ["ntfs"];
  };

  # System Hostname
  networking.hostName = "yoshi";

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;
  hardware.xone.enable = true;

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "auto";
  };

  # Install packages system-wide
  environment.systemPackages = with pkgs; [
    godot_4
    keepassxc
    libnotify
    nomacs
    obsidian
    prismlauncher
    vim
  ];

  # Install apps system-wide
  programs = {
    firefox = {
      enable = true;
    };
    fish.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matthew_hre"];
    };
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
