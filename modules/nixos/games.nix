{
  pkgs,
  config,
  lib,
  username,
  ...
}:
lib.mkIf config.nixos.gaming.enable {
  programs.steam = {
    enable = true;
    gamescopeSession.enable = true;
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
