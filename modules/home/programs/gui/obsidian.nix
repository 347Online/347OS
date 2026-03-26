{
  pkgs,
  lib,
  ...
}:
{
  programs.obsidian = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin pkgs.emptyDirectory;
  };
}
