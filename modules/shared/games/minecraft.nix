{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.shared.gaming.enable {
  home.packages = with pkgs; [prismlauncher];
}
