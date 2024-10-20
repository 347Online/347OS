{
  self,
  username,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./services.nix
  ];

  stylix.image = "${self}/wallpapers/desert.jpg";

  home-manager.users.${username} = {
    # home-config here
  };

  networking.hostName = "Aspen";
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
