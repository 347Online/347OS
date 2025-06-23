{
  pkgs,
  lib,
  config,
  util,
  ...
}:
lib.mkIf (config.user.gui.enable && config.user.personal.enable) {
  home.packages = with pkgs; [
    (lib.mkIf pkgs.stdenv.isLinux element-desktop)
    (util.mkIfElse (pkgs.stdenv.isx86_64 || pkgs.stdenv.isDarwin) pkgs.discord pkgs.webcord)
  ];
}
