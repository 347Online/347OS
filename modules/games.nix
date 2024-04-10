{
  pkgs,
  nix-minecraft,
  lib,
  config,
  ...
}: {
  options = {
    games.enable = lib.mkEnableOption "enables video game module which handles things like Steam and Minecraft";
  };

  config = lib.mkIf config.games.enable {
    home.packages = with pkgs; [
      # prismlauncher # TODO: Declare Minecraft... somehow
    ];

    # TODO: Expand this
  };
}
