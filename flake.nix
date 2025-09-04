{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-homebrew.url = "github:zhaofengli/nix-homebrew";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      nixos-hardware,

      home-manager,
      nix-darwin,
      nix-homebrew,
      nix-vscode-extensions,
      nur,
      plasma-manager,
      sops-nix,
      ...
    }:
    let
      defaultUsername = "katie";

      util = import ./util.nix inputs;

      mkSpecialArgs =
        { pkgs, username }:
        let
          system = pkgs.system;
          homeDirectory = util.mkHomeDirectory pkgs username;
          args = {
            inherit
              self
              nixpkgs
              inputs
              username
              homeDirectory
              util
              system
              ;
            flakeDir = "${homeDirectory}/347OS";
            vscode-extensions = nix-vscode-extensions.extensions.${system};
          };
        in
        args;

      mkExtraSpecialArgs =
        { pkgs, username }:
        let
          specialArgs = mkSpecialArgs { inherit pkgs username; };
        in
        specialArgs
        // {
          inherit util;
        };

      baseModulesHomeManager = [
        ./modules/user
      ];

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          overlays = [ nur.overlays.default ];
        };

      mkDarwin =
        {
          system ? "aarch64-darwin",
          module,
          username ? defaultUsername,
        }:
        let
          pkgs = mkPkgs system;
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = mkSpecialArgs { inherit pkgs username; };
          modules = [
            home-manager.darwinModules.home-manager
            sops-nix.darwinModules.sops
            nix-homebrew.darwinModules.nix-homebrew
            (
              {
                lib,
                config,
                ...
              }:
              {
                environment.pathsToLink = [ "/share/zsh" ];
                home-manager = {
                  backupFileExtension = "bakk";
                  sharedModules = [
                    nur.modules.homeManager.default
                    sops-nix.homeManagerModules.sops
                  ];
                  extraSpecialArgs = mkExtraSpecialArgs { inherit pkgs username; };
                  users.${username}.imports = baseModulesHomeManager ++ [
                    {
                      user.gui.enable = lib.mkForce config.darwin.gui.enable;
                      user.personal.enable = lib.mkForce config.darwin.personal.enable;
                      user.gaming.enable = lib.mkForce config.darwin.gaming.enable;
                    }
                  ];
                };
              }
            )

            ./modules/darwin
            module
          ];
        };

      mkNixos =
        {
          system,
          module,
          username ? defaultUsername,
        }:
        let
          pkgs = mkPkgs system;
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = mkSpecialArgs { inherit pkgs username; };

          modules = [
            home-manager.nixosModules.home-manager
            sops-nix.nixosModules.sops
            (
              {
                lib,
                config,
                ...
              }:
              {
                home-manager = {
                  backupFileExtension = "bakk";
                  sharedModules = [
                    nur.modules.homeManager.default
                    plasma-manager.homeManagerModules.plasma-manager
                    sops-nix.homeManagerModules.sops
                  ];
                  extraSpecialArgs = mkExtraSpecialArgs { inherit pkgs username; };
                  users.${username}.imports = baseModulesHomeManager ++ [
                    {
                      user.gui.enable = lib.mkForce config.nixos.gui.enable;
                      user.personal.enable = lib.mkForce config.nixos.personal.enable;
                      user.gaming.enable = lib.mkForce config.nixos.gaming.enable;
                    }
                  ];
                };
              }
            )

            ./modules/nixos
            module
          ];
        };
    in
    {
      darwinConfigurations = {
        Athena = mkDarwin {
          module = ./hosts/Athena;
        };
        Alice = mkDarwin {
          module = ./hosts/Alice;
          username = "kjanzen";
        };
      };

      nixosConfigurations = {
        Aspen = mkNixos {
          system = "x86_64-linux";
          module = ./hosts/Aspen;
        };

        Arukenia = mkNixos {
          system = "x86_64-linux";
          module = ./hosts/Arukenia;
        };

        Amber = mkNixos {
          system = "x86_64-linux";
          module = ./hosts/Amber;
        };
      };

      formatter = util.forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
