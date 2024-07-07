{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./hyprland

    ./cursor.nix
    ./waybar.nix
  ];

  # home.file = util.toHomeFiles ./dotfiles;

  home.packages = with pkgs; [
    webcord
    blueberry
    pavucontrol
    acpi
  ];
}
