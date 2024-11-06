{lib, ...}: {
  options = {
    shared = {
      codium = {
        enable = lib.mkEnableOption "vscodium setup";

        extraExtensions = lib.mkOption {
          type = with lib.types; listOf package;
          default = [];
        };
      };

      gaming.enable = lib.mkEnableOption "gaming";

      nixvim.enable = lib.mkEnableOption "nixvim setup";
    };

    # DO NOT SET MANUALLY
    shared.gui.enable = lib.mkEnableOption "graphical interface and programs";
  };

  config = {
    shared.nixvim.enable = lib.mkDefault true;
  };
}
