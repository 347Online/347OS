{
  pkgs,
  username,
  homeDirectory,
  rust-toolchain,
  ...
}: {
  imports = [
    ./dev
    ./games
  ];

  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;

    packages = with pkgs; [
      (fenix.${rust-toolchain}.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly

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
