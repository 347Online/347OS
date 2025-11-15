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

  config = lib.mkIf config.user.codium.enable {
    assertions = [
      {
        assertion = config.user.gui.enable;
        message = "Codium can only be enabled on GUI systems";
      }
    ];

    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      mutableExtensionsDir = false;
    };
  };
}
