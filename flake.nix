{
  description = "Katie's Nix Systems";

  inputs = {
    # Waiting for this PR to land in nixpkgs-unstable:
    # https://github.com/NixOS/nixpkgs/pull/374409
    nixpkgs.url = "github:NixOS/nixpkgs/b7352212f8ce5de214da7c4296b7bcd59de37d43";
    nixpkgs-custom.url = "github:347Online/nixpkgs/dev";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
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

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.nix-darwin.follows = "nix-darwin";
      inputs.home-manager.follows = "home-manager";
    };

    nvim-emmet = {
      url = "github:olrtg/nvim-emmet";
      flake = false;
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
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
      nixpkgs-custom,
      nixos-hardware,
      nur,
      nix-darwin,
      home-manager,
      nix-homebrew,
      nix-vscode-extensions,
      nixvim,
      stylix,
      plasma-manager,
      sops-nix,
      ...
    }:
    let
      username = "katie";

      util = import ./util.nix inputs;

      mkNvim =
        {
          pkgs,
          specialArgs ? { },
        }:
        let
          system = pkgs.system;
        in
        inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
          pkgs = pkgs.extend (
            final: prev: {
              vimPlugins = prev.vimPlugins.extend (
                final': prev': {
                  nvim-emmet = prev.vimUtils.buildVimPlugin {
                    pname = "nvim-emmet";
                    version = inputs.nvim-emmet.shortRev;
                    src = inputs.nvim-emmet;
                  };
                }
              );
            }
          );
          module = ./modules/user/programs/nvim;
          extraSpecialArgs = {
            inherit util;
          } // specialArgs;
        };

      mkSpecialArgs =
        pkgs:
        let
          system = pkgs.system;
          homeDirectory = util.mkHomeDirectory pkgs username;
          pkgs-custom = import nixpkgs-custom { inherit system; };
          args = {
            inherit
              self
              pkgs-custom
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
        pkgs:
        let
          specialArgs = mkSpecialArgs pkgs;
        in
        specialArgs
        // {
          inherit util;
          nvim = mkNvim { inherit pkgs specialArgs; };
        };

      baseModulesHomeManager = [
        nixvim.homeManagerModules.nixvim
        ./modules/user
      ];

      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
        };

      mkDarwin =
        system: module:
        let
          pkgs = mkPkgs system;
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = mkSpecialArgs pkgs;
          modules = [
            home-manager.darwinModules.home-manager
            nix-homebrew.darwinModules.nix-homebrew
            stylix.darwinModules.stylix
            sops-nix.darwinModules.sops
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
                  extraSpecialArgs = mkExtraSpecialArgs pkgs;
                  users.${username}.imports = baseModulesHomeManager ++ [
                    {
                      user.gui.enable = lib.mkForce config.darwin.gui.enable;
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
        system: module:
        let
          pkgs = mkPkgs system;
        in
        nixpkgs.lib.nixosSystem {
          specialArgs = mkSpecialArgs pkgs;

          modules = [
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            sops-nix.nixosModules.sops
            (
              {
                lib,
                config,
                ...
              }:
              {
                nixpkgs.config.allowUnfree = true;
                home-manager = {
                  backupFileExtension = "bakk";
                  sharedModules = [
                    nur.modules.homeManager.default
                    plasma-manager.homeManagerModules.plasma-manager
                    sops-nix.homeManagerModules.sops
                  ];
                  extraSpecialArgs = mkExtraSpecialArgs pkgs;
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

      mkIso =
        system:
        let
          pkgs = mkPkgs system;
          specialArgs = mkSpecialArgs pkgs;
        in
        nixpkgs.lib.nixosSystem {
          inherit specialArgs;

          modules = [
            stylix.nixosModules.stylix
            (
              { modulesPath, ... }:
              {
                imports = [
                  "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
                ];

                stylix.image = ./wallpapers/desert.jpg;

                environment.systemPackages =
                  with pkgs;
                  let
                    nvim = mkNvim { inherit pkgs specialArgs; };
                  in
                  [
                    nvim
                    nixfmt-rfc-style
                    git
                    vim
                    lvm2
                  ];

                nixpkgs.hostPlatform = system;
              }
            )
          ];
        };
    in
    {
      # TODO: hosts.nix file loaded by flake.nix
      # Could provide the relevant functions like mkDarwin
      # mkDarwin and mkNixos could call a mkUser
      darwinConfigurations."Athena" = mkDarwin "aarch64-darwin" ./hosts/Athena;
      darwinConfigurations."Alice" = mkDarwin "x86_64-darwin" ./hosts/Alice;

      nixosConfigurations."Aspen" = mkNixos "x86_64-linux" ./hosts/Aspen;
      nixosConfigurations."Amber" = mkNixos "x86_64-linux" ./hosts/Amber;
      nixosConfigurations."Astrid" = mkNixos "aarch64-linux" ./hosts/Astrid;

      nixosConfigurations."ISO-ARM" = mkIso "aarch64-linux";
      nixosConfigurations."ISO-INTEL" = mkIso "x86_64-linux";

      packages = util.forAllSystems (
        {
          pkgs,
          system,
        }:
        let
          specialArgs = mkSpecialArgs pkgs;
        in
        {
          nvim = mkNvim { inherit pkgs specialArgs; };

          homeConfigurations."katie" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = mkExtraSpecialArgs pkgs;

            modules = [
              stylix.homeManagerModules.stylix
              sops-nix.homeManagerModules.sops
              {
                stylix.image = ./wallpapers/desert.jpg;
                nix.package = pkgs.nix;
                user.gui.enable = true;
              }
              ./modules/user/stylix.nix
            ] ++ baseModulesHomeManager;
          };
        }
      );
    };
}
