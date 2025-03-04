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

  sops.defaultSopsFile = ./.arukenia-secrets.yaml;

  stylix.image = "${self}/wallpapers/desert.jpg";

  home-manager.users.${username} = {
    user.nixvim.enable = false;
    services.syncthing.enable = lib.mkForce false;
  };

  networking = {
    hostName = "Arukenia";
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
