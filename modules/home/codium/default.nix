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
      python = lib.mkEnableOption "python integration";
      rust = lib.mkEnableOption "rust integration";
      java = lib.mkEnableOption "java integration";
      
      extraExtensions = lib.mkOption {
        type = with lib.types; listOf package;
        default = [];
      };
    };
  };

  config = lib.mkIf config.lang.jdk.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
