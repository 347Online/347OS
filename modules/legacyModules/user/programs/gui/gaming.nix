{
  pkgs,
  config,
  lib,
  ...
}:
lib.mkIf config.user.gaming.enable {
  home.packages = with pkgs; [
    moonlight-qt
  ];
}
