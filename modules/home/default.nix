{
  lib,
  pkgs,
  username,
  homeDirectory,
  nixvim,
  ...
}: {
  # TODO: Break up into sub-modules

  nixpkgs.config.allowUnfree = true;

  imports = [
    nixvim
    ../code
    ../gaming
  ];

  codeSetup.enable = lib.mkDefault true;

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;

    packages = with pkgs; [
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      # Nix
      alejandra
      nil

      # Shell Tools
      bat
      eza

      # Programming Languages
      nodejs
      python3

      _1password

      # GUI Apps
      _1password-gui
      obsidian
      # maestral # TODO: Fix this cross-platform
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
