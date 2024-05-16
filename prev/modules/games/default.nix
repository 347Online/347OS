{
  pkgs,
  nix-minecraft,
  lib,
  config,
  ...
}: {
  options = {
    enableGaming = lib.mkEnableOption "video games or game launchers like Minecraft and Steam";
  };

  config = lib.mkIf config.enableGaming {
    home.packages = with pkgs; [
      # prismlauncher # TODO: Declare Minecraft... somehow
    ];

    # TODO: Expand this
  };
}
