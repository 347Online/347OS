{ lib, ... }:
{
  options = {
    nixos = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
    };
  };
}
