{
  config,
  pkgs,
  lib,
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
        useOSProber = true;
      };
    };
    supportedFilesystems = ["ntfs"];
  };

  # System Hostname
  networking.hostName = "yoshi";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Edmonton";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_CA.UTF-8";

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["nvidia"];

  # Enable the Desktop Environment.
  services.desktopManager.plasma6.enable = true;

  services.displayManager = {
    sddm = {
      enable = true;
      wayland.enable = true;
    };
    defaultSession = "plasma";
  };

  # Disable some non-essential packages
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

  # Install packages system-wide
  environment.systemPackages = with pkgs; [
    bat
    eza
    gh
    git
    inputs.kwin-effects-forceblur.packages.${pkgs.system}.default
    lazygit
    nodejs_22
    spotify
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    usbutils
    vesktop
    vim
    vscode
    wget
    zoxide
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
    # zsh = {
    #   enable = true;
    #   enableCompletion = true;
    #   autosuggestions.enable = true;
    #   syntaxHighlighting.enable = true;
    #   shellAliases = {
    #     ls = "exa -la --octal-permissions --git";
    #     z = "zoxide";
    #     cat = "bat";
    #   };
    #   ohMyZsh = {
    #     enable = true;
    #     theme = "strug";
    #     plugins = [
    #       "git"
    #       "npm"
    #       "history"
    #       "node"
    #     ];
    #   };
    # };
    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = ["matthew_hre"];
    };
  };

  # Include fonts
  fonts.packages = with pkgs; [
    fira-code
    fira-code-symbols
    work-sans
    (nerdfonts.override {fonts = ["FiraCode"];})
  ];

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # May need to switch this for games
  networking.firewall.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.05"; # Did you read the comment?

  # Enable auto-upgrade
  system.autoUpgrade.enable = true;
  system.autoUpgrade.allowReboot = true;
}
