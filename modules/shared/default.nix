{
  username,
  homeDirectory,
  util,
  config,
  lib,
  ...
}:
{
  imports = [
    ./games
    ./programs

    ./nix.nix
    ./options.nix
  ];

  config = lib.mkMerge [
    {
      home = {
        inherit username homeDirectory;

        sessionVariables.EDITOR = "nvim";

        file = util.toHomeFiles ./dotfiles;
      };

      news.display = "silent";

      # DO NOT EDIT BELOW
      home.stateVersion = "23.11";
    }

    (lib.mkIf config.shared.gui.enable {
      shared.codium.enable = true;
    })
  ];
}
