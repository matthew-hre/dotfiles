{
  description = "NixOS configuration";

  inputs = {
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-cli.url = "github:water-sucks/nixos";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-dcd4151.url = "github:nixos/nixpkgs/dcd4151fd6178395fac82ac4c577b213cec67b4a";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
    };
  };

  outputs = inputs @ {
    home-manager,
    nixpkgs,
    nixpkgs-dcd4151,
    nixos-cli,
    zjstatus,
    ...
  }: {
    nixosConfigurations = {
      yoshi = nixpkgs.lib.nixosSystem rec {
        system = "x86_64-linux";
        
        specialArgs = {
          inherit inputs;

          pkgs-dcd4151 = import nixpkgs-dcd4151 {
            inherit system;
            config.allowUnfree = true;
          };
        };

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          {
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
