let
  util = {
    mkShellAliases = pkgs:
      with pkgs; {
        "bash" = "${bash}/bin/bash";
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

    mkHomeDirectory = pkgs: username:
      if pkgs.stdenv.isDarwin
      then "/Users/${username}"
      else "/home/${username}";
  };
in
  util
