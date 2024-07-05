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
  };

  news.display = "silent";

  # DO NOT EDIT BELOW
  home.stateVersion = "23.11";
}
