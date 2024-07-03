{pkgs, ...}: {
  imports = [
    ./cursor.nix
    ./hyprland.nix
  ];

  home.packages = with pkgs; [
    webcord
  ];
}
