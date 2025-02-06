{
  config,
  lib,
  homeDirectory,
  ...
}:
{
  services.syncthing = {
    enable = lib.mkDefault true;

    passwordFile = builtins.toPath "${homeDirectory}/.secrets/syncthing-gui-passwd.txt";

    settings = {
      gui.user = "katie";

      devices = {
        Amber.id = "F3IMTHP-MIKJMWJ-SPUYHG2-CL4TWES-IHGWO2N-4SOHCOH-ZP2H4ST-FTNB4A4";
        Aspen.id = "3ORETYE-Q4EE3XR-TEK646E-4GQXSI5-CUVN3AF-LCSCJY5-KCOBPJ4-DPPT2AK";
        Athena.id = "BG4POXA-BQIWLZV-7VKGOFX-T7DU2MQ-Q7A6ARE-Z7XHCTO-E3UWLNH-Y3Y4RQM";
        iPhone.id = "QIVADHQ-RRWEEOP-XDJDDLP-HQOPLKD-CJCVHQF-VJOOO44-JTGUZRM-GCID7AZ";
      };

      folders = {
        "~/Sync" = {
          devices = [
            "Amber"
            "Aspen"
            "Athena"
            "iPhone"
          ];
        };
      };
    };
  };
}
