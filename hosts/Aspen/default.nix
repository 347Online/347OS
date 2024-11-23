{
  self,
  username,
  ...
}:
{
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
  time.timeZone = "America/Chicago";

  # Enables cross-build to ARM systems
  boot.binfmt.emulatedSystems = [ "aarch64-linux" ];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
