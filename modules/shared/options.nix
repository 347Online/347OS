{lib, ...}: {
  options = {
    shared = {
      nixvim.enable = lib.mkEnableOption "nixvim setup";
      codium = {
        enable = lib.mkEnableOption "vscodium setup";

        extraExtensions = lib.mkOption {
          type = with lib.types; listOf package;
          default = [];
        };
      };
    };

    # DO NOT SET MANUALLY
    __headless.enable = lib.mkEnableOption "headless operation";
  };

  config = {
    shared.nixvim.enable = lib.mkDefault true;
  };
}
