{ config, lib, ... }:
lib.mkIf config.user.gui.enable {
  programs.elisa = {
    enable = true;
    package = null;

    indexer.scanAtStartup = true;
    player.minimiseToSystemTray = true;
  };
}
