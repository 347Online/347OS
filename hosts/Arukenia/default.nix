{username, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  stylix.image = ./wp-desert.jpg;
  linux.headless.enable = true;
  home-manager.users.${username} = {
    # home-config here
  };

  networking.hostName = "Arukenia";
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
