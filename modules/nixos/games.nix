{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.nixos.gaming.enable {
  home.packages = with pkgs; [
    heroic
  ];
}
