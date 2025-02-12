{
  config,
  lib,
  ...
}:
{
  services.syncthing =
    let
      devices = {
        Amber = {
          id = "F3IMTHP-MIKJMWJ-SPUYHG2-CL4TWES-IHGWO2N-4SOHCOH-ZP2H4ST-FTNB4A4";
          autoAcceptFolders = true;
        };
        Aspen = {
          id = "3ORETYE-Q4EE3XR-TEK646E-4GQXSI5-CUVN3AF-LCSCJY5-KCOBPJ4-DPPT2AK";
          autoAcceptFolders = true;
        };
        Athena.id = "BG4POXA-BQIWLZV-7VKGOFX-T7DU2MQ-Q7A6ARE-Z7XHCTO-E3UWLNH-Y3Y4RQM";
        iPhone.id = "QIVADHQ-RRWEEOP-XDJDDLP-HQOPLKD-CJCVHQF-VJOOO44-JTGUZRM-GCID7AZ";
      };
      allDevices = builtins.attrNames devices;
    in
    {
      enable = true;

      overrideDevices = true;
      overrideFolders = true;

      passwordFile = builtins.toPath config.sops.secrets.syncthing-gui-passwd.path;

      settings = {
        inherit devices;

        gui.user = "katie";

        folders = {
          "~/Sync/Files" = {
            devices = allDevices;
          };
          "~/Sync/Notes" = {
            devices = allDevices;
          };
          "~/Sync/ROMs" = {
            devices = allDevices;
            enable = lib.mkIf (!config.user.personal.enable) false;
          };
        };
      };
    };
}
