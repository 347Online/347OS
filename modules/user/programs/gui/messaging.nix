{
  pkgs,
  lib,
  config,
  util,
  ...
}:
lib.mkIf (config.user.gui.enable && config.user.personal.enable) {
  home.packages =
    let
      discordPkg = (
        util.mkIfElse (pkgs.stdenv.isx86_64 or pkgs.stdenv.isDarwin) pkgs.discord pkgs.webcord
      );
    in
    with pkgs;
    [
      discordPkg
      element-desktop
    ];
}
