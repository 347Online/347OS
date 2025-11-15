{ config, ... }:
{
  flake.darwinModules = {
    essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = config.flake.util.mkEssentials pkgs;
      };
  };
}
