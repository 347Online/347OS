{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # See branch `nur`
    # nur.url = "github:nix-community/NUR";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    fenix = {
      url = "github:nix-community/fenix";
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

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zjstatus = {
      url = "github:dj95/zjstatus";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    fenix,
    nix-darwin,
    home-manager,
    nixpkgs,
    nix-homebrew,
    nix-vscode-extensions,
    zjstatus,
    ...
  }: let
    # overlays = with inputs; [
    #   # ...
    #   (final: prev: {
    #     zjstatus = zjstatus.packages.${prev.system}.default;
    #   })
    # ];
    # Magic value will need to be adapted to run flake on non-darwin or non-ARM systems
    system = "aarch64-darwin";
    username = "katie";
    homeDirectory =
      if nixpkgs.lib.hasSuffix "darwin" system
      then "/Users/${username}"
      else "/home/${username}";
    specialArgs = {inherit inputs system username homeDirectory;};
    extraSpecialArgs =
      specialArgs
      // {
        vscode-extensions = nix-vscode-extensions.extensions.${system};
        inherit fenix;
      };

    baseModulesHomeManager = [
      ./modules/home
    ];

    baseModulesDarwin = [
      home-manager.darwinModules.home-manager
      nix-homebrew.darwinModules.nix-homebrew
      ./modules/darwin
      {
        environment.pathsToLink = ["/share/zsh"];
        home-manager = {
          users.${username}.imports = baseModulesHomeManager;
          backupFileExtension = "bakk";
          inherit extraSpecialArgs;
        };
      }
    ];

    mkDarwin = module:
      nix-darwin.lib.darwinSystem {
        modules = baseModulesDarwin ++ [module];
        inherit specialArgs;
      };
  in {
    darwinConfigurations."Athena" = mkDarwin (import ./hosts/darwin/Athena.nix);
    darwinConfigurations."Alice" = mkDarwin (import ./hosts/darwin/Alice.nix);
  };
}
