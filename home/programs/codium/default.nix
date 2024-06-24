{
  lib,
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
      rust = lib.mkEnableOption "rust integration";
      java = lib.mkEnableOption "java integration";

      extraExtensions = lib.mkOption {
        type = with lib.types; listOf package;
        default = [];
      };
    };
  };

  config = {
    code.codium.rust = lib.mkDefault true;
    code.codium.java = lib.mkDefault true;

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
