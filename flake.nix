{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-apple-silicon = {
      url = "github:nix-community/nixos-apple-silicon";
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
      # TODO: Point back to upstream when this PR lands: https://github.com/nix-community/plasma-manager/pull/537
      # url = "github:nix-community/plasma-manager";
      url = "github:347Online/plasma-manager/keyboard-backlight-brightness";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ghostty = {
      url = "github:ghostty-org/ghostty";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    kclip = {
      url = "github:347Online/kclip-cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      flake-parts,
      nixos-hardware,

      ghostty,
      home-manager,
      kclip,
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

      experimental-features = [
        "nix-command"
        "flakes"
        "pipe-operators"
      ];
      overlays = [
        nix-vscode-extensions.overlays.default
        nur.overlays.default
        ghostty.overlays.default
        # TODO: Fix the overlay in kclip-cli package
        (final: prev: { kclip-cli = kclip.packages.${prev.system}.default; })
      ];

      util = import ./util.nix inputs;

      mkSpecialArgs =
        { system, username }:
        let
          homeDirectory = util.mkHomeDirectory system username;
          args = {
            inherit
              self
              nixpkgs
              inputs
              username
              homeDirectory
              experimental-features
              overlays
              util
              system
              ;
            flakeDir = "${homeDirectory}/347OS";
          };
        in
        args;

      mkExtraSpecialArgs =
        { system, username }:
        let
          specialArgs = mkSpecialArgs { inherit system username; };
        in
        specialArgs
        // {
          inherit util;
        };

      baseModulesHomeManager = [
        ./modules/user
      ];

      mkDarwin =
        {
          system ? "aarch64-darwin",
          module,
          username ? defaultUsername,
        }:
        nix-darwin.lib.darwinSystem {
          specialArgs = mkSpecialArgs { inherit system username; };
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
                  extraSpecialArgs = mkExtraSpecialArgs { inherit system username; };
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
        nixpkgs.lib.nixosSystem {
          specialArgs = mkSpecialArgs { inherit system username; };

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
                    plasma-manager.homeModules.plasma-manager
                    sops-nix.homeManagerModules.sops
                  ];
                  extraSpecialArgs = mkExtraSpecialArgs { inherit system username; };
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

        Arctic = mkNixos {
          system = "aarch64-linux";
          module = ./hosts/Arctic;
        };
      };

      formatter = util.forAllSystems (system: nixpkgs.legacyPackages.${system}.nixfmt-tree);
    };
}
