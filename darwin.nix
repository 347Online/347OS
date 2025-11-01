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
        module = ./hosts/Athena;
      };
      Alice = util.mkDarwin {
        module = ./hosts/Alice;
        username = "kjanzen";
      };
    };
  };
}
