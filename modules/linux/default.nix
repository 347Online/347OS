{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./hyprland
    ./bar.nix
    ./cursor.nix
  ];

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
  ];
}
