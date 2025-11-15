{
  flake.homeModules.default =
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
        ./scripts

        ./accounts.nix
        ./nix.nix
        ./options.nix
        ./sops.nix
      ];

      config = lib.mkMerge [
        {
          home = {
            inherit username homeDirectory;

            sessionVariables.EDITOR = "nvim";

            file = lib.mkMerge [
              (util.toHomeFiles ./dotfiles)
              { ".face.icon".enable = config.user.gui.enable; }
            ];

            packages = [ pkgs.nerd-fonts.jetbrains-mono ] ++ util.mkEssentials pkgs;

          };

          news.display = "silent";

          # DO NOT EDIT BELOW
          home.stateVersion = "23.11";
        }

        (lib.mkIf config.user.gui.enable {
          user.codium.enable = lib.mkDefault true;
        })
      ];
    };
}
