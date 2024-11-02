{
  self,
  username,
  ...
}: {
  imports = [
    ./services

    ./hardware-configuration.nix
    # ./wireguard.nix
  ];

  stylix.image = "${self}/wallpapers/desert.jpg";

  home-manager.users.${username} = {
    # home-config here
  };

  networking.hostName = "Aspen";
  networking.firewall.allowedTCPPorts = [80 443];
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
