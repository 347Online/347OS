{username, ...}: {
  imports = [
    ./hardware-configuration.nix
  ];

  stylix.image = ./wp-desert.jpg;
  linux.headless.enable = true;
  home-manager.users.${username} = {
    shared.nixvim.enable = false;
  };

  networking.hostName = "Arukenia";
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
