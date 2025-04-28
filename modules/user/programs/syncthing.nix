{
  config,
  lib,
  ...
}:
{
  services.syncthing =
    let
      myDevices = {
        Alice.id = "K5ZBRRY-SH636W5-4EOHMC4-5KCX23E-F4BUFMB-INDPI62-MHMEFXU-J5VRHQB";
        Amber.id = "F3IMTHP-MIKJMWJ-SPUYHG2-CL4TWES-IHGWO2N-4SOHCOH-ZP2H4ST-FTNB4A4";
        Aspen.id = "3ORETYE-Q4EE3XR-TEK646E-4GQXSI5-CUVN3AF-LCSCJY5-KCOBPJ4-DPPT2AK";
        Athena.id = "V527BHB-IOR44BQ-TSYQUVZ-OV2JBRV-RTRWY26-QMYHMKY-S3HKMJD-5SNZBQJ";
        iPhone.id = "QIVADHQ-RRWEEOP-XDJDDLP-HQOPLKD-CJCVHQF-VJOOO44-JTGUZRM-GCID7AZ";
      };
      otherDevices = {
        Stardust.id = "YCQVLK2-ZGPGGZO-IAVIRI7-W6GX7YO-WYBNXAX-66YAFTH-ZCXBM3H-2D6QLAF";
      };
      devices = myDevices // otherDevices;

      defaultDevices = builtins.attrNames myDevices;
    in
    {
      enable = true;

      overrideDevices = true;
      overrideFolders = true;

      passwordFile = builtins.toPath config.sops.secrets.syncthing-gui-passwd.path;

      settings = {
        inherit devices;

        gui.user = "katie";

        folders =
          let
            mkPath = name: "~/Sync/${name}";
            mkFolderExt =
              {
                name,
                id ? mkPath name,
                path ? mkPath name,
                devices ? defaultDevices,
                enable ? true,
              }:
              let
                folder = {
                  inherit
                    id
                    devices
                    enable
                    path
                    ;
                  label = name;
                };
              in
              folder;
            mkFolder = name: mkFolderExt { inherit name; };
          in
          {
            files = mkFolder "Files";
            notes = mkFolder "Notes";
            roms = mkFolderExt {
              name = "ROMs";
              enable = lib.mkIf (!config.user.personal.enable) false;
            };
            wifezone = mkFolderExt {
              name = "Wife Zone";
              id = "we.are.us_we.are.love_we.are.one";
              devices = defaultDevices ++ [ "Stardust" ];
              enable = lib.mkIf (!config.user.personal.enable) false;
            };
          };
      };
    };
}
