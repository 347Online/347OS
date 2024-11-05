{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [inputs.nix-minecraft.nixosModules.minecraft-servers];
  nixpkgs.overlays = [inputs.nix-minecraft.overlay];

  users.users.katie.extraGroups = ["minecraft"];

  services.minecraft-servers = {
    enable = true;
    eula = true;
    openFirewall = true;

    servers = {
      vanilla = {
        enable = true;

        serverProperties = {
          spawn-protection = 0;
        };
      };
    };
  };
}
