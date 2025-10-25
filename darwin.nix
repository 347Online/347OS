{ inputs, ... }:
{
  systems = [ "aarch64-darwin" ];
  flake = {
    darwinConfigurations = { };
  };
}
