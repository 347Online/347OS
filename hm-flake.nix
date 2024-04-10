{
  description = "Katie's Nix Systems";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-minecraft = {
      url = "github:12Boti/nix-minecraft";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    nixvim,
    nix-minecraft,
    ...
  } @ inputs: let
    username = "katie";
    macHome = "/Users/${username}";
    linuxHome = "/home/${username}";

    mkHome = system: home: extras: modules:
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs {inherit system;};
        extraSpecialArgs =
          {
            inherit username nixvim;
            homeDirectory = home;
          }
          // extras;

        inherit modules;
      };

    mkHomeConfigs = hosts:
      builtins.map
      (
        {
          hostname,
          extras ? {},
          modules ? [],
          arch ? "aarch64",
          isMac ? false,
        }: let
          os =
            if isMac
            then "darwin"
            else "linux";
          system = "${arch}-${os}";
          home =
            if isMac
            then macHome
            else linuxHome;
          name = "${username}@${hostname}";
        in {
          inherit name;
          value =
            mkHome
            system
            home
            extras
            (modules ++ [./home.nix]);
        }
      )
      hosts;
  in {
    homeConfigurations = builtins.listToAttrs (mkHomeConfigs [
      {
        hostname = "Anathema";
        extras = {inherit nix-minecraft;};
        modules = [
          ./games.nix
          ./cursor.nix
          ./hyprland.nix
        ];
      }
      {
        hostname = "Alice";
        isMac = true;
      }
    ]);
  };
}
