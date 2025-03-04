{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs-pinned.url = "github:NixOS/nixpkgs/632f04521e847173c54fa72973ec6c39a371211c";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-custom.url = "github:347Online/nixpkgs";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-homebrew = {
      url = "github:zhaofengli-wip/nix-homebrew";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    home-manager = {
      # TODO: Switch back to upstream after this PR lands:
      # https://github.com/nix-community/home-manager/pull/6558
      url = "github:347Online/home-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nil = {
      url = "github:oxalica/nil";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    nvim-emmet = {
      url = "github:olrtg/nvim-emmet";
      flake = false;
    };

    stylix = {
      # TODO: Unpin, see this issue: https://github.com/danth/stylix/issues/835
      # ERROR: Plasma WILL crash if this is unpinned before this issue is resolved
      url = "github:danth/stylix/b00c9f46ae6c27074d24d2db390f0ac5ebcc329f";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
      # inputs.nur.follows = "nur"; # TODO: Uncomment this after stylix update
    };

    nix-minecraft = {
      url = "github:Infinidoge/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
      inputs.home-manager.follows = "home-manager";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs-pinned,
      nixpkgs-unstable,
      nixpkgs-custom,
      flake-parts,
      nixos-hardware,

      home-manager,
      nix-darwin,
      nix-homebrew,
      nix-vscode-extensions,
      nixvim,
      nur,
      plasma-manager,
      sops-nix,
      stylix,
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
        pkgs: channel:
        let
          system = pkgs.system;
          homeDirectory = util.mkHomeDirectory pkgs username;
          pkgs-custom = import nixpkgs-custom {
            inherit system;
          };
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
            nixpkgs = channel;
            flakeDir = "${homeDirectory}/347OS";
            vscode-extensions = nix-vscode-extensions.extensions.${system};
          };
        in
        args;

      mkExtraSpecialArgs =
        pkgs: channel:
        let
          specialArgs = mkSpecialArgs pkgs channel;
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
        {
          system,
          channel ? nixpkgs-pinned,
        }:
        import channel {
          inherit system;
          overlays = [ nur.overlays.default ];
        };

      mkDarwin =
        {
          system ? "aarch64-darwin",
          module,
          channel ? nixpkgs-pinned,
        }:
        let
          pkgs = mkPkgs { inherit system channel; };
        in
        nix-darwin.lib.darwinSystem {
          specialArgs = mkSpecialArgs pkgs channel;
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
                  extraSpecialArgs = mkExtraSpecialArgs pkgs channel;
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
        {
          system,
          module,
          channel ? nixpkgs-pinned,
        }:
        let
          pkgs = mkPkgs { inherit system channel; };
        in
        channel.lib.nixosSystem {
          specialArgs = mkSpecialArgs pkgs channel;

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
                home-manager = {
                  backupFileExtension = "bakk";
                  sharedModules = [
                    nur.modules.homeManager.default
                    plasma-manager.homeManagerModules.plasma-manager
                    sops-nix.homeManagerModules.sops
                  ];
                  extraSpecialArgs = mkExtraSpecialArgs pkgs channel;
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
          channel = nixpkgs-pinned;
          pkgs = mkPkgs { inherit system channel; };
          specialArgs = mkSpecialArgs pkgs channel;
        in
        channel.lib.nixosSystem {
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
      darwinConfigurations."Athena" = mkDarwin {
        module = ./hosts/Athena;
        channel = nixpkgs-unstable;
      };

      nixosConfigurations."Aspen" = mkNixos {
        system = "x86_64-linux";
        module = ./hosts/Aspen;
      };

      nixosConfigurations."Arukenia" = mkNixos {
        system = "x86_64-linux";
        module = ./hosts/Arukenia;
      };

      nixosConfigurations."Amber" = mkNixos {
        system = "x86_64-linux";
        module = ./hosts/Amber;
        channel = nixpkgs-unstable;
      };

      nixosConfigurations."Astrid" = mkNixos {
        system = "aarch64-linux";
        module = ./hosts/Astrid;
      };

      nixosConfigurations."ISO-ARM" = mkIso "aarch64-linux";
      nixosConfigurations."ISO-INTEL" = mkIso "x86_64-linux";

      # TODO: Use flake-utils or whatever for this, it's not worth it
      packages = util.forAllSystems (
        {
          pkgs,
          system,
        }:
        let
          channel = nixpkgs-unstable;
          specialArgs = mkSpecialArgs pkgs channel;
        in
        {
          nvim = mkNvim { inherit pkgs specialArgs; };

          homeConfigurations."katie" = home-manager.lib.homeManagerConfiguration {
            inherit pkgs;

            extraSpecialArgs = mkExtraSpecialArgs pkgs channel;

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
