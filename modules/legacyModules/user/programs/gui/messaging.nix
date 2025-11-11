{
  pkgs,
  lib,
  config,
  util,
  ...
}:
lib.mkIf (config.user.gui.enable && config.user.personal.enable) {
  home.packages = [
    (lib.mkIf pkgs.stdenv.isLinux pkgs.element-desktop)
    (util.mkIfElse (pkgs.stdenv.isx86_64 || pkgs.stdenv.isDarwin) pkgs.discord pkgs.webcord)
    (lib.mkIf config.user.personal.zoom.enable pkgs.zoom-us)
  ];
}
