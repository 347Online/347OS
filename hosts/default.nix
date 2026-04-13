{
  self,
  ...
}:
{
  systems = [ "aarch64-darwin" ];
  flake = {
    darwinConfigurations = {
      Athena = self.util.mkDarwin {
        module = ./Athena.nix;
      };
      Alice = self.util.mkDarwin {
        module = ./Alice.nix;
        username = "kjanzen";
      };
    };
  };
}
