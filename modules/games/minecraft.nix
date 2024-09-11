{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.games.enable {
  environment.systemPackages = with pkgs; [prismlauncher];
}
