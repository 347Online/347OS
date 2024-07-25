{nixpkgs, ...}: let
  lib = nixpkgs.lib;
  util = rec {
    mkShellAliases = pkgs:
      with pkgs; {
        # TODO: Use programs.{bat, eza}.enable instead
        cat = "${bat}/bin/bat";
        ls = "${eza}/bin/eza";
        "tree" = "eza --tree";
        "diff" = "delta";

        "branch" = "git branch --show-current";
        "branchhelp" = "git branch --list | rg -v '\\\*' | fzf | awk '{$1=$1};1'";

        "nvim-next" = "nix run ~/src/nix-systems#nvim";
      };

    mkIfElse = condition: trueValue: falseValue:
      lib.mkMerge [
        (lib.mkIf condition trueValue)
        (lib.mkIf (!condition) falseValue)
      ];

    mkHomeDirectory = pkgs: username:
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}";

    listFilesRecursive = dir: acc:
      lib.flatten (lib.mapAttrsToList
        (k: v:
          if v == "regular"
          then "${acc}${k}"
          else listFilesRecursive dir "${acc}${k}/")
        (builtins.readDir "${dir}/${acc}"));

    toHomeFiles = dir:
      builtins.listToAttrs
      (map (name: {
        inherit name;
        value = {source = "${dir}/${name}";};
      }) (listFilesRecursive dir ""));

    vimBind = mode: key: action: {
      inherit mode key;
      options.silent = true;
      action =
        if lib.hasPrefix ":" action
        then action
        else {__raw = action;};
    };
  };
in
  util
