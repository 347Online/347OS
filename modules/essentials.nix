{ config, ... }:
{
  flake = {
    homeModules.essentials =
      { pkgs, ... }:
      {
        home.packages = config.flake.util.mkEssentials pkgs;
      };
    darwinModules.essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = config.flake.util.mkEssentials pkgs;
      };
    nixosModules.essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = config.flake.util.mkEssentials pkgs;
      };
  };
}
