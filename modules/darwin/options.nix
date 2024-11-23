{ lib, ... }:
{
  options = with lib.types; {
    darwin.gui.enable = lib.mkEnableOption "graphical interface and programs";
    darwin.homebrew.enable = lib.mkEnableOption "homebrew setup";
    darwin.loginItems = lib.mkOption {
      type = listOf str;
      default = [ ];
    };
    darwin.dock = {
      browser = lib.mkOption {
        type = enum [
          "Chrome"
          "Safari"
          "Arc"
          "Firefox"
        ];
        default = "Safari";
      };
      apps = lib.mkOption {
        type = listOf str;
        default = [ ];
      };
    };
  };
}
