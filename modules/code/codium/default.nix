{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./userSettings.nix
    ./extensions.nix
  ];

  options = with lib.types; {
    codium = {
      enable = lib.mkEnableOption "vscodium setup";
      extraExtensions = lib.mkOption {
        type = listOf package;
        default = [];
      };
    };
  };

  config = lib.mkIf config.codium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
