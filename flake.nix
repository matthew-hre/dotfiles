{
  description = "NixOS configuration";

  inputs = {
    ghostty = {
      url = "git+ssh://git@github.com/ghostty-org/ghostty";

      inputs.nixpkgs-stable.follows = "nixpkgs";
      inputs.nixpkgs-unstable.follows = "nixpkgs";
    };

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli.url = "github:water-sucks/nixos";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nvf.url = "github:notashelf/nvf";

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs = inputs @ {
    ghostty,
    home-manager,
    nixpkgs,
    nixos-cli,
    nvf,
    plasma-manager,
    zjstatus,
    ...
  }: {
    nixosConfigurations = {
      yoshi = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";

        specialArgs = {
          inherit inputs;
        };

        modules = [
          ./hosts/yoshi/configuration.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          nvf.nixosModules.default
            # plasma-manager.homeManagerModules.plasma-manager
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
            home-manager.extraSpecialArgs = {inherit inputs;};
            home-manager.users.matthew_hre = import ./home/default.nix;
          }
        ];
      };
    };
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
  };
}
