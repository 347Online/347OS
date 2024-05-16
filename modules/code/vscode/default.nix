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
    vscodiumSetup = {
      enable = lib.mkEnableOption "vscodium setup";
      extraExtensions = lib.mkOption {
        type = listOf package;
        default = [];
      };
    };
  };

  config = lib.mkIf config.vscodiumSetup.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
