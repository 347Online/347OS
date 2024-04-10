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
    darwinPackages = self.darwinConfigurations."Athena".pkgs;
    darwinBaseConfiguration = import ./darwinBaseConfiguration.nix;
  in {
    darwinConfigurations."Athena" = nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        darwinBaseConfiguration
        
        home-manager.darwinModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.users.katie = import ./home-manager/home.nix {
            homeDirectory = "/Users/katie";
            pkgs = darwinPackages;
          };
          home-manager.extraSpecialArgs = {inherit nixvim;};
        }
      ];
    };

    # Expose the package set, including overlays, for convenience.
    inherit darwinPackages;
  };
}
