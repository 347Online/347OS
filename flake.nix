{
  description = "Katie's Nix Systems";

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

    nixvim-module = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
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
    nixvim-module,
    nix-homebrew,
    nix-vscode-extensions,
    ...
  }: let
    username = "katie";

    mkBaseSystem = {system}: {
      pkgs = import nixpkgs {inherit system;};
      vscode-extensions = nix-vscode-extensions.extensions.${system};
    };

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

      vscode-extensions = nix-vscode-extensions.extensions.${system};
      nixvim = nixvim-module.homeManagerModules.nixvim;

      darwinArgs =
        {
          inherit username;
          hostPlatform = system;
        }
        // inputs;

      hmArgs = {inherit nixvim vscode-extensions;};
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
                  pkgs = import nixpkgs {inherit system;};
                }
                // home
                // {inherit username;});
              home-manager.extraSpecialArgs = hmArgs; #{inherit nixvim vscode-extensions;};
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

        specialArgs = darwinArgs;
      };
  in {
    # TODO: Map over files in hosts/darwin?
    darwinConfigurations."Athena" = mkDarwin (import ./hosts/Athena {});
    darwinConfigurations."Alice" = mkDarwin (import ./hosts/Alice {});
  };
}
