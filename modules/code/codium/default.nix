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
    code.codium = {
      enable = lib.mkEnableOption "vscodium setup";
      extraExtensions = lib.mkOption {
        type = listOf package;
        default = [];
      };
    };
  };

  config = lib.mkIf config.code.codium.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
