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

  stylix.targets.vscode.enable = false;

  programs.vscode = lib.mkIf config.user.codium.enable {
    # enable = true;
    package = pkgs.vscodium;
    mutableExtensionsDir = false;
  };
}
