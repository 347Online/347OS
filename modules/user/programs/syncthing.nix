{
  config,
  lib,
  homeDirectory,
  ...
}:
{
  services.syncthing = {
    enable = lib.mkDefault true;

    guiAddress = "0.0.0.0:8384";
    passwordFile = builtins.toPath "${homeDirectory}/.secrets/syncthing-gui-passwd.txt";

    settings = {
      gui.user = "katie";

      devices = {
        Amber.id = "F3IMTHP-MIKJMWJ-SPUYHG2-CL4TWES-IHGWO2N-4SOHCOH-ZP2H4ST-FTNB4A4";
        Aspen.id = "3ORETYE-Q4EE3XR-TEK646E-4GQXSI5-CUVN3AF-LCSCJY5-KCOBPJ4-DPPT2AK";
      };

      folders = {
        "~/Sync" = {
          devices = [
            "Amber"
            "Aspen"
          ];
        };
      };
    };
  };
}
