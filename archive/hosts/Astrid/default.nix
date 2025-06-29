{
  self,
  lib,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./nginx.nix
  ];

  sops.defaultSopsFile = ./.astrid-secrets.yaml;

  home-manager.users.${username} = {
    user.nixvim.enable = false;
    services.syncthing.enable = lib.mkForce false;
  };

  networking = {
    hostName = "Astrid";
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
