{
  pkgs,
  username,
  homeDirectory,
  nixvim-module,
  ...
}: {
  # TODO: Break up into sub-modules

  imports = [
    nixvim-module.homeManagerModules.nixvim
    ../code
    ../gaming
  ];

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
