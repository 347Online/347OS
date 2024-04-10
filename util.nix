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

    mkHome = {
      system,
      username ? defaultUsername,
      homeDirectory ? mkHomeDirectory {},
      useGlobalPkgs ? true,
      ...
    } @ home: let
      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;
    in {
      home-manager = {
        inherit useGlobalPkgs;
        extraSpecialArgs = {inherit nixvim vscode-extensions;};
        users."${username}" = import ./modules/home.nix (
          home // {inherit pkgs username homeDirectory;}
        );
      };
    };

    # UNTESTED
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
      home-manager.lib.homeManagerConfiguration mkHome {};

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
      home ? {},
      username ? defaultUsername,
    }: let
      system = mkSystem {
        mac = true;
        intel = !appleSilicon;
      };

      homeDirectory = mkHomeDirectory {
        inherit username;
        mac = true;
      };

      specialArgs =
        {
          inherit system username homeDirectory;
          hostPlatform = system;
          useGlobalPkgs = true;
        }
        // inputs;

      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;
    in
      nix-darwin.lib.darwinSystem {
        inherit system specialArgs;

        modules = [
          ./modules/darwin
          mkHome
        ];
      };
  };
in
  util
