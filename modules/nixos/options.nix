{ lib, ... }:
{
  options = {
    nixos = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
      gaming.enable = lib.mkEnableOption "gaming";
      personal.enable = lib.mkEnableOption "this machine as a personal device, as opposed to a work device";
      unfree-allowed = lib.mkOption {
        type = with lib.types; listOf str;
        default = [ ];
      };
    };
  };
}
