{
  description = "NixOS configuration";

  inputs = {
    alacritty-theme.url = "github:alexghr/alacritty-theme.nix";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

<<<<<<< HEAD
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    };
=======
    # kwin-effects-forceblur = {
    #   url = "github:taj-ny/kwin-effects-forceblur";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };
>>>>>>> f23fdfd (take 2)

    nixos-cli.url = "github:water-sucks/nixos";

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

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
    alacritty-theme,
    home-manager,
    nixpkgs,
    nixos-cli,
    zjstatus,
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
            nixpkgs.overlays = [
              alacritty-theme.overlays.default
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
