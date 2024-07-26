{
  pkgs,
  lib,
  config,
  ...
}: {
  config = lib.mkIf (!config.linux.headless) {
    environment.systemPackages = with pkgs; [
      webcord
      paper-plane
      element-desktop # TODO: Only if a private machine
      blueberry
      pavucontrol
    ];
  };
}
