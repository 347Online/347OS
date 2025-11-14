{
  config,
  ...
}:
let
  util = config.flake.util;
in
{
  systems = [ "aarch64-darwin" ];
  flake = {
    darwinConfigurations = {
      Athena = util.mkDarwin {
        module = ./hosts/Athena.nix;
      };
      Alice = util.mkDarwin {
        module = ./hosts/Alice.nix;
        username = "kjanzen";
      };
    };
  };
}
