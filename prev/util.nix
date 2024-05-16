# TODO: Consider moving utils into its own flake
{
  nixpkgs,
  nix-vscode-extensions,
  nixvim-module,
  home-manager,
  nix-darwin,
  fenix,
  ...
} @ inputs: let
  defaultUsername = "katie";

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
      pkgs = import nixpkgs {
        inherit system;
        config = {
          allowUnfree = true;
          allowUnsupportedSystem = true;
        };
        overlays = [fenix.overlays.default];
      };
      vscode-extensions = nix-vscode-extensions.extensions.${system};
      nixvim = nixvim-module.homeManagerModules.nixvim;
    };

    mkHome = {
      system,
      username ? defaultUsername,
      homeDirectory ? mkHomeDirectory {},
      rust-toolchain,
      ...
    } @ home: let
      inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;
    in {
      home-manager = {
        extraSpecialArgs = {inherit nixvim vscode-extensions;};
        users."${username}" = import ./modules/home.nix (
          home // {inherit pkgs username homeDirectory rust-toolchain;}
        );
      };
    };

    # UNTESTED
    # mkStandalone = {
    #   system,
    #   username ? defaultUsername,
    # }: let
    #   inherit (mkBaseSystem system) pkgs vscode-extensions nixvim;

    #   homeDirectory = mkHomeDirectory {
    #     inherit username;
    #     mac = isMac system;
    #   };
    # in
    #   home-manager.lib.homeManagerConfiguration mkHome {};

    # mkNixos = {
    #   intel ? false,
    #   username ? defaultUsername,
    #   rust-toolchain ? "stable",
    #   home ? {},
    # }: {
    #   # TODO:
    # };

    mkDockApp = pkg: name: "${pkg}/Applications/${name}.app";

    mkDarwin = {
      appleSilicon ? true,
      username ? defaultUsername,
      dockApps ? [],
      rust-toolchain ? "stable",
      home ? {},
    }: let
      system = mkSystem {
        mac = true;
        intel = !appleSilicon;
      };

      homeConfig =
        {
          programs.git.extraConfig.credential.helper = "osxkeychain";
        }
        // home;

      homeDirectory = mkHomeDirectory {
        inherit username;
        mac = true;
      };

      specialArgs =
        {
          inherit system pkgs username homeDirectory dockApps rust-toolchain;
          hostPlatform = system;
        }
        // homeConfig
        // inputs;

      inherit (mkBaseSystem system) pkgs;
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
