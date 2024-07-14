{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./cursor.nix
    ./waybar.nix
  ];

  programs.fuzzel.enable = true;

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
    acpi
  ];
}
