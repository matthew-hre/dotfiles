Here's a practical migration path:

## Step 1: Convert one home-manager module as a test

Pick something simple like `bat.nix`:

**Before:**
```nix
# home/configs/bat.nix
{
  osConfig,
  lib,
  ...
}:
lib.optionalAttrs osConfig.users.matthew_hre.configs.bat {
  programs.bat = {
    enable = true;
    config.theme = "Dracula";
  };
}
```

**After:**
```nix
# home/configs/bat.nix
{ config, lib, ... }: {
  options.matthew_hre.bat = {
    enable = lib.mkEnableOption "bat configuration";
  };
  
  config = lib.mkIf config.matthew_hre.bat.enable {
    programs.bat = {
      enable = true;
      config.theme = "Dracula";
    };
  };
}
```

Update `hosts/toad/configuration.nix` to test:
```nix
# Add this temporarily alongside your existing config
home-manager.users.matthew_hre = {
    home.bat.enable = true;
};

# Keep your old way too for now:
users.matthew_hre.configs.bat = true;
```

Test with `rebuild-test`. If it works, remove the old way.

## Step 2: Convert remaining home configs

Do the same pattern for all files in `home/configs/`:

```nix
# home/configs/git.nix
{ config, lib, ... }: {
  options.matthew_hre.git = {
    enable = lib.mkEnableOption "git configuration";
    userName = lib.mkOption {
      type = lib.types.str;
      default = "Matthew Hrehirchuk";
    };
    userEmail = lib.mkOption {
      type = lib.types.str;
      default = "matthew_hre@outlook.com";
    };
  };
  
  config = lib.mkIf config.matthew_hre.git.enable {
    programs.git = {
      enable = true;
      userName = config.matthew_hre.git.userName;
      userEmail = config.matthew_hre.git.userEmail;
      # ... rest of config
    };
  };
}
```

## Step 3: Update nested module structures

For shell and wayland:

```nix
# home/shell/fish.nix
{ config, lib, pkgs, ... }: {
  options.matthew_hre.shell.fish = {
    enable = lib.mkEnableOption "fish shell";
  };
  
  config = lib.mkIf config.matthew_hre.shell.fish.enable {
    programs.fish = {
      enable = true;
      # ... your fish config
    };
  };
}
```

## Step 4: Remove old home/default.nix options

Once all home modules are converted:

**Before:**
```nix
# home/default.nix - DELETE most of this
options.users.matthew_hre = {
  enable = lib.mkEnableOption "enable user config";
  configs = { ... all these options ... };
};
```

**After:**
```nix
# home/default.nix - Simplified
{ config, lib, pkgs, ... }: {
  imports = [
    ./configs
    ./editors
    ./shell
    ./wayland
  ];

  # Just the user account creation stays at system level
  # (move this to a system module later)
}
```

## Step 5: Convert one system module

Start with hibernation since you already have options defined:

```nix
# system/services/hibernation.nix
{ config, lib, ... }: {
  options.system.hibernation = {
    enable = lib.mkEnableOption "hibernation support";
    swapDeviceUUID = lib.mkOption {
      type = lib.types.str;
      description = "UUID of swap device";
    };
    lidAction = lib.mkOption {
      type = lib.types.enum [ "hibernate" "suspend" "suspend-then-hibernate" "ignore" ];
      default = "suspend-then-hibernate";
    };
    hibernateDelay = lib.mkOption {
      type = lib.types.str;
      default = "30m";
    };
  };
  
  config = lib.mkIf config.system.hibernation.enable {
    # Your existing config here
  };
}
```

## Step 6: Convert simpler system modules

```nix
# system/services/docker.nix
{ config, lib, ... }: {
  options.system.docker = {
    enable = lib.mkEnableOption "Docker";
    enableOnBoot = lib.mkOption {
      type = lib.types.bool;
      default = false;
    };
  };
  
  config = lib.mkIf config.system.docker.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = config.system.docker.enableOnBoot;
    };
    systemd.services."docker.socket".wantedBy = [ "sockets.target" ];
  };
}
```

## Step 7: Create system module default.nix files

```nix
# system/services/default.nix
{
  imports = [
    ./boot.nix
    ./docker.nix
    ./greetd.nix
    ./hibernation.nix
    ./openssh.nix
    ./openvpn.nix
    ./pipewire.nix
    ./power.nix
  ];
}
```

Do the same for `system/hardware/`, `system/programs/`, etc.

## Step 8: Update host configs

**Before:**
```nix
# hosts/toad/configuration.nix
imports = [
  ./hardware-configuration.nix
  "${system}/core"
  "${system}/shared"
  "${system}/hardware/bluetooth.nix"
  # ... 20 more imports
];

users.matthew_hre = {
  enable = true;
  configs = {
    bat = true;
    btop = true;
    # ... lots more
  };
};
```

**After:**
```nix
# hosts/toad/configuration.nix
{ ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../system  # Just one import!
  ];

  system = {
    docker.enable = true;
    hibernation = {
      enable = true;
      swapDeviceUUID = "773e93e2-0dd1-48f1-95a8-7f8acb4fb177";
    };
    hardware = {
      bluetooth.enable = true;
      fprintd.enable = true;
    };
  };

  home-manager.users.matthew_hre = {
    matthew_hre = {
      bat.enable = true;
      btop.enable = true;
      git.enable = true;
      shell = {
        fish.enable = true;
        ghostty.enable = true;
      };
      wayland = {
        niri.enable = true;
        dunst.enable = true;
      };
    };
  };
}
```

## Step 9: Add system/default.nix

```nix
# system/default.nix
{
  imports = [
    ./core
    ./hardware
    ./network
    ./programs
    ./services
    ./shared
  ];
}
```

## Testing strategy:

1. Convert modules one at a time
2. Keep both old and new options working simultaneously
3. Test with `rebuild-test` after each change
4. Once confirmed working, remove old option
5. Move to next module

Start with home-manager (steps 1-4), then system (steps 5-9). This way if something breaks, you can roll back easily.

Want me to show the converted version of a specific module to get you started?