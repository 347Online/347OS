{ config, ... }:
{
  flake.nixosModules = {
    essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = config.flake.util.mkEssentials pkgs;
      };
  };
}
