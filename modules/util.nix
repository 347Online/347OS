{nixpkgs, ...}: let
  lib = nixpkgs.lib;
  util = rec {
    mkShellAliases = pkgs:
      with pkgs; {
        # TODO: Use lib.getExe or whatever it's called
        "cat" = "${bat}/bin/bat";
        "ls" = "${eza}/bin/eza";
        "tree" = "${eza}/bin/eza --tree";
        "grep" = "${ripgrep}/bin/rg";
        "diff" = "${delta}/bin/delta";

        "code" = "${vscodium}/bin/codium";

        "git" = "${git}/bin/git";
        "branch" = "${git}/bin/git branch --show-current";

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
