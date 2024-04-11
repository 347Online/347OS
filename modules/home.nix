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

      alejandra
      bat
      eza
      nodejs
      python3
      _1password-gui
      _1password
      # maestral
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
