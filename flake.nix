{
  description = "NixOS configuration";

  inputs = {
    dustpan.url = "github:matthew-hre/dustpan";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    rpc-lsp.url = "github:matthew-hre/discord-rpc-lsp-flake";

    solaar = {
      url = "github:Svenum/Solaar-Flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    vicinae.url = "github:vicinaehq/vicinae";
  };

  outputs = inputs @ {
    ghostty,
    home-manager,
    nixpkgs,
    ...
  }: {
    nixosConfigurations = {
      toad = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          hostname = "toad";
        };

        modules = [
          ./hosts/toad/configuration.nix
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              ghostty.packages.x86_64-linux.default
            ];
            nixpkgs.overlays = [
              inputs.niri.overlays.niri
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              hostname = "toad";
            };
            home-manager.users.matthew_hre = import ./home/default.nix;
          }
        ];
      };
      thwomp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          hostname = "thwomp";
        };

        modules = [
          ./hosts/thwomp/configuration.nix
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              ghostty.packages.x86_64-linux.default
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              hostname = "thwomp";
            };
            home-manager.users.matthew_hre = import ./home/default.nix;
          }
        ];
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
