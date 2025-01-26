{
  pkgs,
  pkgs-custom,
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
      # TODO: Enable on linux once I get it fixed
      # TODO: Use from official nixpkgs if/when PR lands
      # https://github.com/NixOS/nixpkgs/pull/376817
      (lib.mkIf pkgs.stdenv.isDarwin pkgs-custom.teamtalk5)
    ];
}
