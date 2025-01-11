{ lib, ... }:
{
  options = {
    linux = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
    };
  };
}
