{
  pkgs,
  lib,
  config,
  util,
  ...
}:
lib.mkIf config.shared.gaming.enable {
  home.packages = with pkgs; [
    (util.mkIfElse (pkgs.stdenv.isx86_64 or pkgs.stdenv.isDarwin) discord webcord)
  ];
}
