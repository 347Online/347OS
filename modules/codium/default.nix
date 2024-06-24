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

  options = {
    code.codium = {
      enable = lib.mkEnableOption "vscodium setup";
      extraExtensions = lib.mkOption {
        type = with lib.types; listOf package;
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
