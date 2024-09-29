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
    };

    # DO NOT SET MANUALLY
    __headless.enable = lib.mkEnableOption "headless operation";
  };
}
