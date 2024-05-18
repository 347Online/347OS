{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    lang.nodejs.enable = lib.mkEnableOption "nodejs";
  };

  config = lib.mkIf config.lang.nodejs.enable {
    home.packages = with pkgs; [
      # TODO: Replace pinned nixpkgs node version with version manager
      # e.g. rtx-cli
      nodejs
    ];
  };
}
