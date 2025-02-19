{ lib, config, ... }:
lib.mkIf config.user.gui.enable {
  programs.ghostty = {
    enable = true;

    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
