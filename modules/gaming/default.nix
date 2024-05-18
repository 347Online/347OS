{
  pkgs,
  nix-minecraft,
  lib,
  config,
  ...
}: {
  options = {
    gamingSetup.enable = lib.mkEnableOption "gaming setup";
  };

  config = lib.mkIf config.gamingSetup.enable {
    home.packages = with pkgs; [
      # prismlauncher # TODO: Declare Minecraft... somehow
    ];
  };
}
