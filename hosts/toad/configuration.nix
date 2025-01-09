{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  # Bootloader
  boot = {
    loader = {
      systemd-boot.enable = false;
      efi.efiSysMountPoint = "/boot";
      grub = {
        enable = true;
        efiSupport = true;
        efiInstallAsRemovable = true;
        device = "nodev";
        gfxmodeEfi = "2880x1920";
        font = "${pkgs.nerd-fonts.fira-code}/share/fonts/truetype/NerdFonts/FiraCode/FiraCodeNerdFontMono-Regular.ttf";
        fontSize = 24;
      };
    };
  };

  nix.settings.experimental-features = ["nix-command" "flakes"];

  networking = {
    hostName = "toad";
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

  # Enable the KDE Plasma Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  specialisation = {
    niri = {
      configuration = {
        environment.systemPackages = [
          pkgs.swww
        ];

        programs.niri = {
          enable = true;
          package = pkgs.niri;
        };
        services.greetd.settings.default_session.command = lib.mkDefault "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --cmd niri --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";

        services.desktopManager.plasma6.enable = lib.mkDefault false;
      };
    };
  };

  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time -r --cmd startplasma-wayland --asterisks --theme border=green;text=white;prompt=green;time=green;action=purple;button=green;container=black;input=white";
        user = "greeter";
      };
    };
  };

  services.journald.extraConfig = "SystemMaxUse=1G";

  environment.plasma6.excludePackages = with pkgs.kdePackages; [
    kate
  ];

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General.Enable = "Source,Sink,Media,Socket";
    };
  };

  # Enable OpenGL
  hardware.graphics.enable = true;

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

  services.fwupd.enable = true;

  environment.sessionVariables.NIXOS_OZONE_WL = "1";
  environment.sessionVariables.ELECTRON_OZONE_PLATFORM_HINT = "wayland";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.matthew_hre = {
    isNormalUser = true;
    home = "/home/matthew_hre";
    description = "Matthew Hrehirchuk";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.fish;
  };

  users.defaultUserShell = pkgs.fish;

  security.sudo.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  environment.systemPackages = with pkgs; [
    hunspell
    hunspellDicts.en_CA
    hunspellDicts.en_US
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    kdePackages.kconfig
    kde-rounded-corners
    libnotify
    libreoffice-qt
    nomacs
    obsidian
    fprintd
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    vesktop
    vim
  ];

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

  fonts.packages = with pkgs; [
    departure-mono
    fira-code
    fira-code-symbols
    work-sans
    nerd-fonts.fira-code
  ];

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

  services.fprintd.enable = true;
  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-vfs0090;

  # TODO: disable this later
  virtualisation.docker.enable = true;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11"; # Did you read the comment?
}
