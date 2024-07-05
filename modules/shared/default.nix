{
  pkgs,
  lib,
  username,
  homeDirectory,
  util,
  ...
}: {
  imports = [
    ./programs
    ./nix.nix
    ./rust.nix
  ];

  home = {
    inherit username homeDirectory;

    sessionVariables.EDITOR = "nvim";

    file = util.toHomeFiles ./dotfiles;

    activation = {
      miseInstall =
        lib.hm.dag.entryAfter ["installPackages"]
        /*
        bash
        */
        ''
          if ${pkgs.mise}/bin/mise install; then
            echo "mise install succeeded"
          else
            echo "mise install failed"
          fi
        '';
    };

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      bat
      eza
      ripgrep
      mise

      _1password

      obsidian
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
