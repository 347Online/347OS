{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.user.gaming.enable {
  home.packages = with pkgs; [
    (lib.mkIf pkgs.stdenv.isLinux prismlauncher)
  ];
}
