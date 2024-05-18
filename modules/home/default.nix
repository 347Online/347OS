{
  pkgs,
  lib,
  username,
  homeDirectory,
  nixvim,
  ...
}: {
  # TODO: Break up into sub-modules

  imports = [
    nixvim

    ./dotfiles
    ./nix.nix

    ../code
    ../gaming
  ];

  code.enable = lib.mkDefault true;
  gaming.enable = lib.mkDefault false;

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;

    packages = with pkgs; [
      # Essentials
      (nerdfonts.override {fonts = ["JetBrainsMono"];})

      _1password
      _1password-gui

      obsidian

      maestral # Untested on Linux
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
