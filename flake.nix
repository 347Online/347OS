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

    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
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

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    apple-silicon-support = {
      url = "github:tpwrules/nixos-apple-silicon/fc4503fa956c4f07b5cb0b7d446a04be25786402";
      inputs.nixpkgs.follows = "nixpkgs";
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
    neovim-nightly-overlay,
    nixvim,
    stylix,
    ...
  }: let
    username = "katie";

    util = import ./util.nix inputs;

    mkNvim = pkgs: let
      system = pkgs.system;
    in
      inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
        pkgs = pkgs.extend (final: prev: {
          vimPlugins = prev.vimPlugins.extend (final': prev': {
            vim-be-good = prev.vimUtils.buildVimPlugin {
              pname = "vim-be-good";
              src = inputs.vim-be-good;
              version = inputs.vim-be-good.shortRev;
            };
          });
        });
        module =
          (import ./modules/shared/programs/nvim)
          // {
            package = neovim-nightly-overlay.packages.${system}.default;
          };
        extraSpecialArgs = {inherit util;};
      };

    mkSpecialArgs = pkgs: let
      system = pkgs.system;
    in {
      inherit inputs username util system;
      inherit (pkgs.stdenv) isDarwin;
      homeDirectory = util.mkHomeDirectory pkgs username;
    };

    mkExtraSpecialArgs = pkgs: let
      system = pkgs.system;
    in
      (mkSpecialArgs pkgs)
      // {
        inherit util;
        nvim = mkNvim pkgs;
        vscode-extensions = nix-vscode-extensions.extensions.${system};
      };

    baseModulesHomeManager = [
      nixvim.homeManagerModules.nixvim
      ./modules/shared
    ];

    mkPkgs = system:
      import nixpkgs {
        inherit system;
      };

    mkDarwin = {
      module,
      system ? "aarch64-darwin",
    }: let
      pkgs = mkPkgs system;
    in
      nix-darwin.lib.darwinSystem {
        specialArgs = mkSpecialArgs pkgs;
        modules = [
          home-manager.darwinModules.home-manager
          nix-homebrew.darwinModules.nix-homebrew
          stylix.darwinModules.stylix
          {
            environment.pathsToLink = ["/share/zsh"];
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports = baseModulesHomeManager;
            };
          }

          ./modules/darwin
          module
        ];
      };

    mkLinux = {
      module,
      system ? "aarch64-linux",
    }: let
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
                    __headless.enable = lib.mkForce config.linux.headless.enable;
                  }
                ];
            };
          })

          ./modules/linux
          module
        ];
      };
  in {
    # TODO: hosts.nix file loaded by flake.nix
    # Could provide the relevant functions like mkDarwin
    # mkDarwin and mkLinux could call a mkHome
    darwinConfigurations."Athena" = mkDarwin {module = ./hosts/Athena;};
    darwinConfigurations."Alice" = mkDarwin {module = ./hosts/Alice;};

    nixosConfigurations."Arctic" = mkLinux {module = ./hosts/Arctic;};
    nixosConfigurations."Arukenia" = mkLinux {module = ./hosts/Arukenia;};

    packages = util.forAllSystems ({
      pkgs,
      system,
    }: {
      nvim = mkNvim pkgs;
    });
  };
}
