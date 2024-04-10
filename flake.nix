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

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-minecraft = {
      url = "github:12Boti/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nix-darwin,
    home-manager,
    nixpkgs,
    nixvim,
    nix-homebrew,
    ...
  }: let
    username = "katie";

    darwinPackages = self.darwinConfigurations."Athena".pkgs; # TODO: Remove this hardcoded system

    mkDarwin = {
      appleSilicon ? true,
      modules ? [],
      home ? {},
      disableHomebrewAutoMigrate ? false,
    }: let
      system =
        if appleSilicon
        then "aarch64-darwin"
        else "x86_64-darwin";
    in
      nix-darwin.lib.darwinSystem {
        inherit system;
        modules =
          [
            ./modules/darwin

            home-manager.darwinModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users."${username}" = import ./modules/home.nix ({
                  homeDirectory = "/Users/${username}";
                  pkgs = darwinPackages; # TODO: Do this a different way
                }
                // home
                // {inherit username;});
              home-manager.extraSpecialArgs = {inherit nixvim;};
            }

            nix-homebrew.darwinModules.nix-homebrew
            {
              nix-homebrew = {
                enable = true;
                user = username;
              };
            }
          ]
          ++ modules;

        specialArgs =
          {
            inherit username;

            hostPlatform = system;
          }
          // inputs;
      };
  in {
    darwinConfigurations."Athena" = mkDarwin import ./hosts/Athena;
    darwinConfigurations."Alice" = mkDarwin import ./hosts/Alice;
  };
}
