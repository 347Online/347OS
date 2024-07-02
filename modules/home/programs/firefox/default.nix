{
  pkgs,
  lib,
  ...
}: {
  programs.firefox = {
    enable = lib.mkIf (!pkgs.stdenv.isDarwin) true;
  };
}
