{
  config,
  lib,
  util,
  ...
}:
{
  options = {
    user = {
      codium = {
        enable = lib.mkEnableOption "vscodium setup";

        extraExtensions = lib.mkOption {
          type = with lib.types; listOf package;
          default = [ ];
        };
      };

      personal.enable = lib.mkEnableOption "this machine as a personal device, as opposed to a work device";

      gaming.enable = lib.mkEnableOption "gaming";

      firefox.extraPinnedItems = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
      };
    };

    # DO NOT SET MANUALLY
    user.gui.enable = lib.mkEnableOption "graphical interface and programs";
  };

  config = {
    # user.codium.enable = util.mkIfElse config.user.gui.enable (lib.mkDefault true) false;
  };
}
