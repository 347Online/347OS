{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    nixos-hardware.url = "github:NixOS/nixos-hardware";

    nur.url = "github:nix-community/NUR";

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

    vim-be-good = {
      flake = false;
      url = "github:ThePrimeagen/vim-be-good";
    };

    tsc-nvim = {
      flake = false;
      url = "github:dmmulroy/tsc.nvim";
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    nixos-hardware,
    nur,
    nix-darwin,
    home-manager,
    nix-homebrew,
    nix-vscode-extensions,
    nil,
    nixvim,
    stylix,
    ...
  }: let
    username = "katie";

    util = import ./util.nix inputs;

    mkNvim = pkgs: let
      system = pkgs.system;
    in
      inputs.nixvim.legacyPackages.${system}.makeNixvimWithModule {
        pkgs = pkgs.extend (final: prev: {
          vimPlugins = prev.vimPlugins.extend (final': prev': {
            vim-be-good = prev.vimUtils.buildVimPlugin {
              pname = "vim-be-good";
              src = inputs.vim-be-good;
              version = inputs.vim-be-good.shortRev;
            };
            tsc-nvim = prev.vimUtils.buildVimPlugin {
              pname = "tsc-nvim";
              src = inputs.tsc-nvim;
              version = inputs.tsc-nvim.shortRev;
            };
          });
        });
        module = ./modules/shared/programs/nvim;
        extraSpecialArgs = {inherit util;};
      };

    mkSpecialArgs = pkgs: let
      system = pkgs.system;
    in {
      inherit self inputs username util system;
      inherit (pkgs.stdenv) isDarwin;
      homeDirectory = util.mkHomeDirectory pkgs username;
      vscode-extensions = nix-vscode-extensions.extensions.${system};
    };

    mkExtraSpecialArgs = pkgs:
      (mkSpecialArgs pkgs)
      // {
        inherit util;
        nvim = mkNvim pkgs;
      };

    baseModulesHomeManager = [
      nixvim.homeManagerModules.nixvim
      ./modules/shared
    ];

    mkPkgs = system:
      import nixpkgs {
        inherit system;
      };

    mkDarwin = system: module: let
      pkgs = mkPkgs system;
    in
      nix-darwin.lib.darwinSystem {
        specialArgs = mkSpecialArgs pkgs;
        modules = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          stylix.darwinModules.stylix
          ({
            lib,
            config,
            ...
          }: {
            environment.pathsToLink = ["/share/zsh"];
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports =
                baseModulesHomeManager
                ++ [
                  {
                    shared.gui.enable = lib.mkForce config.darwin.gui.enable;
                  }
                ];
            };
          })

          ./modules/darwin
          module
        ];
      };

    mkLinux = system: module: let
      pkgs = mkPkgs system;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = mkSpecialArgs pkgs;

        modules = [
          home-manager.nixosModules.home-manager
          stylix.nixosModules.stylix
          ({
            lib,
            config,
            ...
          }: {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports =
                baseModulesHomeManager
                ++ [
                  {
                    shared.gui.enable = lib.mkForce config.linux.gui.enable;
                  }
                ];
            };
          })

          ./modules/linux
          module
        ];
      };

    mkIso = system: let
      pkgs = mkPkgs system;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = mkSpecialArgs pkgs;

        modules = [
          stylix.nixosModules.stylix
          ({modulesPath, ...}: {
            imports = [
              "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
            ];

            stylix.image = ./wallpapers/desert.jpg;

            environment.systemPackages = with pkgs; [
              (mkNvim pkgs)
              alejandra
              git
              vim
              lvm2
            ];

            nixpkgs.hostPlatform = system;
          })
        ];
      };
  in {
    # TODO: hosts.nix file loaded by flake.nix
    # Could provide the relevant functions like mkDarwin
    # mkDarwin and mkLinux could call a mkHome
    darwinConfigurations."Athena" = mkDarwin "aarch64-darwin" ./hosts/Athena;
    darwinConfigurations."Alice" = mkDarwin "x86_64-darwin" ./hosts/Alice;

    nixosConfigurations."Aspen" = mkLinux "x86_64-linux" ./hosts/Aspen;

    nixosConfigurations."ISO-ARM" = mkIso "aarch64-linux";
    nixosConfigurations."ISO-INTEL" = mkIso "x86_64-linux";

    packages = util.forAllSystems ({
      pkgs,
      system,
    }: {
      nvim = mkNvim pkgs;

      homeConfigurations."katie" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        extraSpecialArgs = mkExtraSpecialArgs pkgs;

        modules =
          [
            stylix.homeManagerModules.stylix
            {
              stylix.image = ./wallpapers/desert.jpg;
              nix.package = pkgs.nix;
              shared.gui.enable = true;
            }
            ./modules/shared/stylix.nix
          ]
          ++ baseModulesHomeManager;
      };
    });
  };
}
