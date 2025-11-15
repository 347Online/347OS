{ config, ... }:
{
  flake.homeModules = {
    essentials =
      { pkgs, ... }:
      {
        home.packages = config.flake.util.mkEssentials pkgs;
      };
  };
}
