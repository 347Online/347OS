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
    shared.nixvim.enable = false;
  };

  networking = {
    hostName = "Astrid";
    networkmanager.enable = true; # Easiest to use and most distros use this by default.
    firewall.allowedTCPPorts = [
      80
      443
    ];
  };

  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
