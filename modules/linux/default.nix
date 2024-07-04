{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./hyprland
    ./cursor.nix
  ];

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
  ];
}
