{
  pkgs,
  nix-minecraft,
  lib,
  config,
  ...
}: {
  options = {
    games.enable = lib.mkEnableOption "video games or game launchers like Minecraft and Steam";
  };

  config = lib.mkIf config.games.enable {
    home.packages = with pkgs; [
      # prismlauncher # TODO: Declare Minecraft... somehow
    ];

    # TODO: Expand this
  };
}
