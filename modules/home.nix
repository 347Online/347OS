{
  pkgs,
  username,
  homeDirectory,
  ...
}: {
  imports = [
    ./dev
    ./games.nix
  ];

  nixpkgs.config = {
    allowUnsupportedSystem = true;
    allowUnfree = true;
  };

  programs.home-manager.enable = true;

  home = {
    inherit
      username
      homeDirectory
      ;

    packages = with pkgs; [
      (pkgs.nerdfonts.override {fonts = ["JetBrainsMono"];})

      alejandra
      bat
      cargo
      eza
      nodejs
      python3
      # maestral
    ];
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
