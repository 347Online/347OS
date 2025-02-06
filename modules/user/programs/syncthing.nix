{
  config,
  lib,
  homeDirectory,
  ...
}:
{
  services.syncthing = {
    enable = true;

    passwordFile = builtins.toPath "${homeDirectory}/.secrets/syncthing-gui-passwd.txt";

    settings = {
      gui.user = "katie";

      devices = {
        Amber.id = "F3IMTHP-MIKJMWJ-SPUYHG2-CL4TWES-IHGWO2N-4SOHCOH-ZP2H4ST-FTNB4A4";
      };

      folders = {
        "~/Sync" = {
          devices = [ "Amber" ];
        };
      };
    };
  };
}
