{
  pkgs,
  config,
  lib,
  ...
}:
{
  options = {
    darwin = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
      gaming.enable = lib.mkEnableOption "gaming";
      personal.enable = lib.mkEnableOption "this machine as a personal device, as opposed to a work device";
      homebrew.enable = lib.mkEnableOption "homebrew setup";
      loginItems = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
      };
      dock = {
        browserApp = lib.mkOption {
          type = lib.types.enum [
            "Chrome"
            "Safari"
            "Arc"
            "Firefox"
          ];
          default = "Firefox";
        };
        browserAppPath =
          let
            paths = {
              Safari = "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app";
              Chrome = "/Applications/Google Chrome.app";
              Arc = "/Applications/Arc.app";
              Firefox = "/Applications/Firefox.app";
            };
          in
          lib.mkOption {
            type = lib.types.str;
            default = paths.${config.darwin.dock.browserApp};
          };
        email = {
          enable = lib.mkEnableOption "email app in dock";
          app = lib.mkOption {
            type = lib.types.enum [
              "Thunderbird"
              "Mail"
            ];
            default = "Thunderbird";
          };
          path =
            let
              inherit (config.darwin.dock.email) app;
              paths = {
                Thunderbird = "${pkgs.thunderbird}/Applications/Thunderbird.app";
                Mail = "/System/Applications/Mail.app";
              };
            in
            lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = paths.${app};
            };
        };
        apps = lib.mkOption {
          type = with lib.types; listOf str;
          default = [ ];
        };
      };
    };
  };
}
