{ nixpkgs, ... }:
let
  lib = nixpkgs.lib;
  util = rec {
    linuxSystems = [
      "aarch64-linux"
      "x86_64-linux"
    ];

    darwinSystems = [
      "aarch64-darwin"
      "x86_64-darwin"
    ];

    supportedSystems = linuxSystems ++ darwinSystems;

    forAllSystems =
      f:
      builtins.listToAttrs (
        builtins.map (system: {
          name = system;
          value = f system;
        }) supportedSystems
      );

    mkIfElse =
      condition: trueValue: falseValue:
      lib.mkMerge [
        (lib.mkIf condition trueValue)
        (lib.mkIf (!condition) falseValue)
      ];

    mkHomeDirectory =
      pkgs: username: if pkgs.stdenv.isDarwin then "/Users/${username}" else "/home/${username}";

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
util
