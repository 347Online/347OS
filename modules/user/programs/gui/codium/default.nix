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

  programs.vscode = lib.mkIf config.shared.codium.enable {
    enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
  };
}
