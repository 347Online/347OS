{
  pkgs,
  lib,
  config,
  util,
  ...
}:
lib.mkIf config.user.gui.enable {
  programs.ghostty = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
