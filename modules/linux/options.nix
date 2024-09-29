{lib, ...}: {
  options = {
    linux = {
      headless.enable = lib.mkEnableOption "headless operation";
      gaming.enable = lib.mkEnableOption "gaming";
    };
  };
}
