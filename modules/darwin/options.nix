{lib, ...}: {
  options = with lib.types; {
    darwin.loginItems = lib.mkOption {
      type = listOf str;
      default = [];
    };
    darwin.dock = {
      browser = lib.mkOption {
        type = enum ["Chrome" "Safari" "Arc" "Firefox"];
        default = "Safari";
      };
      apps = lib.mkOption {
        type = listOf str;
        default = [];
      };
    };
  };
}
