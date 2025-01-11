{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.user.gaming.enable {
  home.packages = with pkgs; [ prismlauncher ];
}
