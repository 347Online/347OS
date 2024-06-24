{
  lib,
  config,
  ...
}: {
  options = {
    gaming.enable = lib.mkEnableOption "gaming";
  };

  config = lib.mkIf config.gaming.enable {
    # Gaming stuff
  };
}
