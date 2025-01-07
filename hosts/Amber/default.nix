{
  self,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  linux.gui.enable = true;

  stylix.image = "${self}/wallpapers/neon-city.jpg";

  networking.hostName = "Amber";
  time.timeZone = "America/Chicago";

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };

  home-manager.users.${username} = {
    shared.gaming.enable = true;
  };

  programs.steam.enable = true;

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
