let
  util = {
    mkShellAliases = pkgs:
      with pkgs; {
        "bash" = "${bash}/bin/bash";
        "cat" = "${bat}/bin/bat";
        "ls" = "${pkgs.eza}/bin/eza";
        "tree" = "${pkgs.eza}/bin/eza --tree";
        "grep" = "${pkgs.ripgrep}/bin/rg";
        "diff" = "${pkgs.delta}/bin/delta";

        "code" = "${vscodium}/bin/codium";

        "git" = "${git}/bin/git";
        "branch" = "${git}/bin/git branch --show-current";

        "python3" = "${python3}/bin/python";
        # "vi" = "nvim";
        # "vim" = "nvim";
      };
  };
in
  util
