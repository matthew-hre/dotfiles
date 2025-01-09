{
  pkgs,
  self,
  inputs,
  ...
}: let
  mod = "${self}/system";
in {
  imports = [
    "${mod}/hardware-configuration.nix"
    "${mod}/core"
    "${mod}/hardware/bluetooth.nix"
    "${mod}/hardware/nvidia.nix"
    "${mod}/network"
    "${mod}/services/greetd.nix"
    "${mod}/services/pipewire.nix"
    "${mod}/services/power.nix"
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
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  services.journald.extraConfig = "SystemMaxUse=1G";

  # Disable some non-essential packages
  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
    okular
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable OpenGL
  hardware.graphics.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "auto";

  # Install packages system-wide
  environment.systemPackages = with pkgs; [
    godot_4
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    kdePackages.kconfig
    keepassxc
    libnotify
    libreoffice-qt
    nomacs
    obsidian
    prismlauncher
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    vesktop
    vim
  ];

  # Install apps system-wide
  programs = {
    firefox = {
      enable = true;
    };
    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
    fish.enable = true;
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matthew_hre"];
    };
  };

  # Include fonts
  fonts.packages = with pkgs; [
    departure-mono
    fira-code
    fira-code-symbols
    work-sans
    nerd-fonts.fira-code
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  services.openvpn.servers = {
    mruVPN = {
      config = ''config /home/matthew_hre/.config/openvpn/mruVPN.conf '';
      autoStart = false;
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
