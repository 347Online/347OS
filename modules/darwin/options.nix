{ lib, ... }:
{
  options = with lib.types; {
    darwin = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
      gaming.enable = lib.mkEnableOption "gaming";
      personal.enable = lib.mkEnableOption "this machine as a personal device, as opposed to a work device";
      homebrew.enable = lib.mkEnableOption "homebrew setup";
      loginItems = lib.mkOption {
        type = listOf str;
        default = [ ];
      };
      dock = {
        browser = lib.mkOption {
          type = enum [
            "Chrome"
            "Safari"
            "Arc"
            "Firefox"
          ];
          default = "Firefox";
        };
        apps = lib.mkOption {
          type = listOf str;
          default = [ ];
        };
      };
    };
  };
}
