{
  description = "Example Darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
    nixvim,
    ...
  }: let
    darwinPackages = self.darwinConfigurations."Athena".pkgs; # TODO: Remove this hardcoded system
  in {
    darwinConfigurations."Athena" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./modules/darwin

        home-manager.darwinModules.home-manager

        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.katie = import ./modules/home.nix {
            homeDirectory = "/Users/katie";
            pkgs = darwinPackages; # TODO: Do this a different way
          };
          home-manager.extraSpecialArgs = {inherit nixvim;};
        }
      ];
    };
  };
}
