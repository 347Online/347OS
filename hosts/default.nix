{
  config,
  ...
}:
{
  systems = [ "aarch64-darwin" ];
  flake = {
    darwinConfigurations = {
      Athena = config.flake.util.mkDarwin {
        module = ./Athena.nix;
      };
      Alice = config.flake.util.mkDarwin {
        module = ./Alice.nix;
        username = "kjanzen";
      };
    };
  };
}
