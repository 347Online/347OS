{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./cursor.nix
    ./hyprland.nix
  ];

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
  ];
}
