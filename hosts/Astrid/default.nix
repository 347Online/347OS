{
  self,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
    ./nginx.nix
  ];

  stylix.image = "${self}/wallpapers/desert.jpg";

  home-manager.users.${username} = {
    user.nixvim.enable = false;
    services.syncthing.enable = false;
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
