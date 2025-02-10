{
  description = "NixOS configuration";

  inputs = {
    ghostty = {
      url = "github:ghostty-org/ghostty";

      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    niri.url = "github:sodiboo/niri-flake";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nvf.url = "github:notashelf/nvf";

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    zjstatus.url = "github:dj95/zjstatus";
  };

  outputs = inputs @ {
    ghostty,
    home-manager,
    nixpkgs,
    zjstatus,
    ...
  }: {
    nixosConfigurations = {
      yoshi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
          hostname = "yoshi";
        };

        modules = [
          ./hosts/yoshi/configuration.nix
          home-manager.nixosModules.home-manager
          {
            environment.systemPackages = [
              ghostty.packages.x86_64-linux.default
            ];
            nixpkgs.overlays = [
              (final: prev: {
                zjstatus = zjstatus.packages.${prev.system}.default;
              })
            ];
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = {
              inherit inputs;
              hostname = "yoshi";
            };
            home-manager.users.matthew_hre = import ./home/default.nix;
          }
        ];
      };
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
              (final: prev: {
                zjstatus = zjstatus.packages.${prev.system}.default;
              })
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
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
