{ config, lib, ... }:
{
  services.syncthing = {
    enable = lib.mkIf config.user.personal.enable true;
  };
}
