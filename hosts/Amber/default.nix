{
  self,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  stylix.image = "${self}/wallpapers/neon-city.jpg";

  networking.hostName = "Amber";
  time.timeZone = "America/Chicago";

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };

  home-manager.users.${username} = {
    shared.gaming.enable = true;
  };

  linux.gui.enable = true;

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
