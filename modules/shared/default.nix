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
      # miseInstall = lib.hm.dag.entryAfter ["installPackages"] ''
      #   # rtx has been renamed to mise
      #   ${pkgs.rtx}/bin/mise install
      # '';
    };

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      bat
      eza
      ripgrep
      rtx

      _1password
      _1password-gui

      obsidian
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
