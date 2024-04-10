{
  nixpkgs,
  nix-vscode-extensions,
  nixvim-module,
  home-manager,
  nix-darwin,
  ...
} @ inputs: let
  lib = nixpkgs.lib;
  defaultUsername = "katie";
  isMac = system: lib.strings.hasInfix system "darwin";

  util = rec {
    mkSystem = {
      mac ? false,
      intel ? false,
    }: let
      arch =
        if intel
        then "x86_64"
        else "aarch64";
      os =
        if mac
        then "darwin"
        else "linux";
    in ''${arch}-${os}'';

    mkHomeDirectory = {
      username ? defaultUsername,
      mac ? false,
    }: let
      parentDir =
        if mac
        then "Users"
        else "home";
    in "/${parentDir}/${username}";

    mkBaseSystem = system: {
      pkgs = import nixpkgs {inherit system;};
      vscode-extensions = nix-vscode-extensions.extensions.${system};
      nixvim = nixvim-module.homeManagerModules.nixvim;
    };

    mkStandalone = {
      system,
      username ? defaultUsername,
    }: let
      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;

      homeDirectory = mkHomeDirectory {
        inherit username;
        mac = isMac system;
      };
    in
      home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = {inherit username nixvim homeDirectory;};
      };

    mkNixos = {
      intel ? false,
      username ? defaultUsername,
    }: let
      system = mkSystem {inherit intel;};
      nixosModules = [
        ./modules/nixos
        home-manager.nixosModules.home-manager
      ];

      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;
    in {
    };

    mkDarwin = {
      appleSilicon ? true,
      modules ? [],
      home ? {},
      disableHomebrewAutoMigrate ? false,
      username ? defaultUsername,
    }: let
      system = mkSystem {
        mac = true;
        intel = !appleSilicon;
      };

      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;

      darwinModules = [
        ./modules/darwin
      ];
    in
      nix-darwin.lib.darwinSystem {
        inherit system;

        modules =
          [
            {
              home-manager = {
                useGlobalPkgs = true;
                extraSpecialArgs = {inherit nixvim vscode-extensions;};
                users."${username}" = import ./modules/home.nix ({
                    inherit pkgs username;

                    homeDirectory = mkHomeDirectory {
                      inherit username;
                      mac = true;
                    };
                  }
                  // home);
              };

              nix-homebrew = {
                enable = true;
                user = username;
              };
            }
          ]
          ++ darwinModules
          ++ modules;

        specialArgs =
          {
            inherit username;
            hostPlatform = system;
          }
          // inputs;
      };
  };
in
  util
