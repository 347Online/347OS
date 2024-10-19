{lib, ...}: {
  options = {
    linux = {
      gui.enable = lib.mkEnableOption "graphical interface and programs";
      gaming.enable = lib.mkEnableOption "gaming";
    };
  };
}
