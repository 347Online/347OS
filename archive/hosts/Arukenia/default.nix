{
  self,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  stylix.image = "${self}/wallpapers/desert.jpg";

  home-manager.users.${username} = {
    # home-config here
  };

  networking.hostName = "Arukenia";
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
