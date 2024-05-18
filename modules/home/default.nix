{
  pkgs,
  username,
  homeDirectory,
  nixvim,
  fenix,
  ...
}: {
  # TODO: Break up into sub-modules

  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [fenix.overlays.default];

  imports = [
    nixvim
    ../code
    ../gaming
  ];

  code.enable = true;

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
