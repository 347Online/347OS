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

  stylix.enable = true;
  stylix.image = ./wp-neon-city.jpg;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
  ];
}
