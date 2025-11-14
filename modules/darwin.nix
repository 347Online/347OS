{
  config,
  ...
}:
{
  systems = [ "aarch64-darwin" ];
  flake = {
    darwinConfigurations = {
      Athena = config.flake.util.mkDarwin {
        module = ./hosts/Athena.nix;
      };
      Alice = config.flake.util.mkDarwin {
        module = ./hosts/Alice.nix;
        username = "kjanzen";
      };
    };
  };
}
