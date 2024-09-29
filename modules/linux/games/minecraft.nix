{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.linux.gaming.enable {
  environment.systemPackages = with pkgs; [prismlauncher];
}
