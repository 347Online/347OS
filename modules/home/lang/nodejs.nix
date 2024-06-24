{
  config,
  lib,
  ...
}: {
  options = {
    lang.nodejs.enable = lib.mkEnableOption "nodejs";
  };

  config =
    lib.mkIf config.lang.nodejs.enable {
    };
}
