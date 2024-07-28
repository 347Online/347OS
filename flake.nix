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
      url = "github:tpwrules/nixos-apple-silicon";
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
    fenix,
    nix-homebrew,
    nix-vscode-extensions,
    nil,
    neovim-nightly-overlay,
    nixvim,
    stylix,
    ...
  }: let
    username = "katie";
    linuxSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];
    darwinSystems = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    supportedSystems = linuxSystems ++ darwinSystems;

    forSystem = system: f:
      f rec {
        inherit system;

        pkgs = import nixpkgs {
          inherit system;
        };
      };

    forSystems = f: systems:
      nixpkgs.lib.genAttrs systems (system: (forSystem system f));

    forAllSystems = f:
      forSystems f
      supportedSystems;

    util = import ./modules/util.nix inputs;

    mkPkgs = system:
      import nixpkgs {
        inherit system;
      };

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
      nvim = mkNvim pkgs;
    };

    mkExtraSpecialArgs = pkgs: let
      system = pkgs.system;
    in
      (mkSpecialArgs pkgs)
      // {
        inherit fenix util;
        vscode-extensions = nix-vscode-extensions.extensions.${system};
      };

    baseModulesHomeManager = [
      nixvim.homeManagerModules.nixvim
      ./modules/shared
    ];

    baseModulesHomeManagerGui =
      baseModulesHomeManager
      ++ [
        {
          stylix.targets = {
            waybar.enable = false;
          };
        }
      ];

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
          (import ./modules/darwin)
          {
            environment.pathsToLink = ["/share/zsh"];
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports = baseModulesHomeManagerGui;
            };
          }
          module
        ];
      };
  in {
    darwinConfigurations."Athena" = mkDarwin {module = ./hosts/Athena;};
    darwinConfigurations."Alice" = mkDarwin {module = ./hosts/Alice;};

    nixosConfigurations."Arctic" = let
      system = "aarch64-linux";
      pkgs = mkPkgs system;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = mkSpecialArgs pkgs;

        modules = [
          stylix.nixosModules.stylix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports = baseModulesHomeManagerGui;
            };
          }

          ./modules/shared/stylix.nix
          ./modules/linux
          ./hosts/Arctic
        ];
      };

    nixosConfigurations."Arukenia" = let
      system = "x86_64-linux";
      pkgs = mkPkgs system;
    in
      nixpkgs.lib.nixosSystem {
        specialArgs = mkSpecialArgs pkgs;

        modules = [
          home-manager.nixosModules.home-manager
          {
            nixpkgs.config.allowUnfree = true;
            home-manager = {
              backupFileExtension = "bakk";
              sharedModules = [nur.hmModules.nur];
              extraSpecialArgs = mkExtraSpecialArgs pkgs;
              users.${username}.imports = baseModulesHomeManager;
            };
          }

          ./modules/linux
          ./hosts/Arukenia
        ];
      };

    packages = forAllSystems ({
      pkgs,
      system,
    }: {
      nvim = mkNvim pkgs;
    });

    devShells = forAllSystems ({system, ...}: let
      pkgs = import nixpkgs {
        inherit system;
        overlays = [fenix.overlays.default];
      };
      mkRust = toolchain:
        pkgs.mkShell {
          buildInputs = with pkgs; [
            (pkgs.fenix.${toolchain}.withComponents [
              "cargo"
              "clippy"
              "rust-src"
              "rustc"
              "rustfmt"
            ])
            rust-analyzer-nightly
            rustup
          ];

          shellHook = ''
            echo "Using Rust devShell - $(cargo --version)"
          '';
        };
    in {
      rust = mkRust "stable";
      rust-beta = mkRust "beta";
      rust-nightly = mkRust "complete";
    });
  };
}
