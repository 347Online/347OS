{
  pkgs,
  config,
  lib,
  username,
  ...
}:
lib.mkIf config.nixos.gaming.enable {
  jovian = {
    steam = {
      user = username;
      updater.splash = "vendor";
    };

    steamos = {
      useSteamOSConfig = true;
    };
  };

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      heroic
    ];
  };
}
