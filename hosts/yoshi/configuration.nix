{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
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

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # System Hostname
  networking = {
    hostName = "yoshi";
    networkmanager = {
      enable = true;
      wifi.powersave = false;
      wifi.scanRandMacAddress = false;
    };
  };

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --cmd startplasma-wayland --asterisks --theme border=green;text=whit;prompt=green;time=green;action=purple;button=green;container=black;input=white";
        user = "greeter";
      };
    };
  };

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

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  # Enable Bluetooth
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General.Enable = "Source,Sink,Media,Socket";
    };
  };

  # Enable OpenGL
  hardware.graphics.enable = true;

  # Configure GPUs
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;

    # Required for laptop GPU offloading
    prime = {
      amdgpuBusId = "PCI:7:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };

  # Configure Asus specific libraries
  services.supergfxd.enable = true;
  services.asusd.enable = true;
  services.asusd.enableUserService = true;

  # Laptop Power Management

  services.power-profiles-daemon.enable = false;

  services.tlp = {
    enable = true;
    settings = {
      TLP_DEFAULT_MODE = "BAT";

      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 90;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 75;
    };
  };

  # Define user account
  users.users.matthew_hre = {
    isNormalUser = true;
    home = "/home/matthew_hre";
    description = "Matthew Hrehirchuk";
    extraGroups = ["wheel" "networkmanager"];
    shell = pkgs.zsh;
  };

  users.defaultUserShell = pkgs.zsh;

  security.sudo.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

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
    zsh.enable = true;
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

  # May need to switch this for games
  networking.firewall = {
    enable = true;
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?
}
