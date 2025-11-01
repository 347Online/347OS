{
  inputs,
  config,
  lib,
  ...
}:
let
  inherit (config.flake.variables)
    defaultUsername
    experimental-features
    overlays
    ;

  util = rec {
    mkIfElse =
      condition: trueValue: falseValue:
      lib.mkMerge [
        (lib.mkIf condition trueValue)
        (lib.mkIf (!condition) falseValue)
      ];

    mkHomeDirectory =
      system: username:
      let
        mkLinuxLikeHome =
          homePath:
          if (!lib.strings.hasSuffix "linux" system) then
            builtins.warn "Unknown OS system double ${system}, homeDirectory location may be incorrect" homePath
          else
            homePath;
      in
      if lib.strings.hasSuffix "darwin" system then
        "/Users/${username}"
      else
        mkLinuxLikeHome "/home/${username}";

    mkSpecialArgs =
      {
        system,
        username ? defaultUsername,
      }:
      let
        homeDirectory = util.mkHomeDirectory system username;
        inherit (inputs) nixpkgs;
      in
      {
        inherit
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

    mkExtraSpecialArgs =
      {
        system,
        username ? defaultUsername,
      }:
      let
        specialArgs = mkSpecialArgs { inherit system username; };
      in
      specialArgs
      // {
        inherit util;
      };

    mkDarwin =
      {
        module,
        system ? "aarch64-darwin",
        username ? defaultUsername,
      }:
      inputs.nix-darwin.lib.darwinSystem {
        specialArgs = util.mkSpecialArgs { inherit system username; };
        modules = [
          inputs.home-manager.darwinModules.home-manager
          inputs.sops-nix.darwinModules.sops
          inputs.nix-homebrew.darwinModules.nix-homebrew
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
                  inputs.nur.modules.homeManager.default
                  inputs.sops-nix.homeManagerModules.sops
                ];
                extraSpecialArgs = util.mkExtraSpecialArgs { inherit system username; };
                users.${username}.imports = [
                  ./modules/user
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
        module,
        system,
        username ? defaultUsername,
      }:
      inputs.nixpkgs.lib.nixosSystem {
        specialArgs = util.mkSpecialArgs { inherit system username; };

        modules = [
          inputs.home-manager.nixosModules.home-manager
          inputs.sops-nix.nixosModules.sops
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
                  inputs.nur.modules.homeManager.default
                  inputs.plasma-manager.homeModules.plasma-manager
                  inputs.sops-nix.homeManagerModules.sops
                ];
                extraSpecialArgs = util.mkExtraSpecialArgs { inherit system username; };
                users.${username}.imports = [
                  ./modules/user
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

    listFilesRecursive =
      dir: acc:
      lib.flatten (
        lib.mapAttrsToList (
          k: v: if v == "regular" then "${acc}${k}" else listFilesRecursive dir "${acc}${k}/"
        ) (builtins.readDir "${dir}/${acc}")
      );

    toHomeFiles =
      dir:
      builtins.listToAttrs (
        map (name: {
          inherit name;
          value = {
            source = "${dir}/${name}";
          };
        }) (listFilesRecursive dir "")
      );

    vimBindLua = mode: key: bind: {
      inherit mode key;
      options.silent = true;
      action.__raw = bind;
    };

    vimBindCmd = mode: key: bind: {
      inherit mode key;
      options.silent = true;
      action = bind;
    };

    vimBind =
      mode: key: bind:
      if lib.hasPrefix ":" bind then vimBindCmd mode key bind else vimBindLua mode key bind;

    dummy-package =
      p: name:
      p.runCommand name { } ''
        mkdir $out
      '';
  };
in
{
  flake = { inherit util; };
}
