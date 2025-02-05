{
  config,
  lib,
  homeDirectory,
  ...
}:
{
  services.syncthing = {
    enable = lib.mkIf config.user.personal.enable true;

    passwordFile = builtins.toPath "${homeDirectory}/.secrets/syncthing-gui-passwd.txt";

    settings = {
      gui.user = "katie";
    };
  };
}
