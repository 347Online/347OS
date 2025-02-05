{
  pkgs,
  config,
  lib,
  username,
  homeDirectory,
  util,
  ...
}:
{
  imports = [
    ./games
    ./programs

    ./nix.nix
    ./options.nix
    ./scripts.nix
    ./sops.nix
  ];

  config = lib.mkMerge [
    {
      home = {
        inherit username homeDirectory;

        sessionVariables.EDITOR = "nvim";

        file = lib.mkMerge [
          (util.toHomeFiles ./dotfiles)
          {
            "Downloads/Katie Janzen Resume 2025.pdf" = {
              enable = config.user.personal.enable;

              source = pkgs.fetchurl {
                url = "https://347online.me/resume.pdf";
                hash = "sha256-f2haSLhCIqu83C/yandfCL8RESsP9Eb3zsA4r8bApEE=";
              };
            };
          }
        ];
      };

      news.display = "silent";

      # DO NOT EDIT BELOW
      home.stateVersion = "23.11";
    }

    (lib.mkIf config.user.gui.enable {
      user.codium.enable = true;
    })
  ];
}
