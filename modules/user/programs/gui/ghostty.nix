{
  pkgs,
  lib,
  config,
  ...
}:
lib.mkIf config.user.gui.enable {
  programs.ghostty = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    enableZshIntegration = true;
    enableBashIntegration = true;

    settings = {
      auto-update = "download";
      auto-update-channel = "tip";
      confirm-close-surface = false;
      cursor-style-blink = false;
      shell-integration-features = [ "no-cursor" ];
    };
  };
}
