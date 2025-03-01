{
  pkgs,
  pkgs-custom,
  lib,
  config,
  util,
  ...
}:
lib.mkIf (config.user.gui.enable && config.user.personal.enable) {
  home.packages = with pkgs; [
    (lib.mkIf pkgs.stdenv.isLinux element-desktop)
    # TODO: Enable on linux once I get it fixed
    # TODO: Use from official nixpkgs if/when PR lands
    # https://github.com/NixOS/nixpkgs/pull/376817
    # TODO: Broken
    # (lib.mkIf pkgs.stdenv.isDarwin pkgs-custom.teamtalk5)
    (util.mkIfElse (pkgs.stdenv.isx86_64 || pkgs.stdenv.isDarwin) pkgs.discord pkgs.webcord)
  ];
}
