{
  description = "NixOS configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    nixos-cli.url = "github:water-sucks/nixos";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    kwin-effects-forceblur = {
      url = "github:taj-ny/kwin-effects-forceblur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    nixos-cli,
    nixvim,
    alacritty-theme,
    ...
  }: {
    nixosConfigurations = {
      system = "x86_64-linux";

      yoshi = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};

        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          nixos-cli.nixosModules.nixos-cli
          {
            nixpkgs.overlays = [alacritty-theme.overlays.default];
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
