{
  self,
  inputs,
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

    nixosConfigurations = {
      Amber = self.util.mkNixos {
        system = "x86_64-linux";
        module = ./Amber;
      };
    };
  };
}
