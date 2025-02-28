{ config, lib, ... }:
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

      nixvim.enable = lib.mkEnableOption "nixvim setup";
    };

    # DO NOT SET MANUALLY
    user.gui.enable = lib.mkEnableOption "graphical interface and programs";
  };

  config = {
    user.nixvim.enable = lib.mkDefault true;
  };
}
