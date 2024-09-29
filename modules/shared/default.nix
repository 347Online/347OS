{
  username,
  homeDirectory,
  util,
  config,
  lib,
  ...
}: {
  imports = [
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

    (lib.mkIf (!config.__headless.enable) {
      shared.codium.enable = true;
    })
  ];
}
