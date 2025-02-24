{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.user.gui.enable {
  home.packages = with pkgs; [
    (lib.mkIf pkgs.stdenv.isLinux shortwave)
  ];
}
