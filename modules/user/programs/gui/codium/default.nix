{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [
    ./userSettings.nix
    ./extensions.nix
  ];

  programs.vscode = lib.mkIf config.user.codium.enable {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
  };
}
