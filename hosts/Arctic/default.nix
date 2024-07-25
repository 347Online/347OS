{
  imports = [
    ./hardware.nix
  ];

  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  networking.hostName = "Arctic";
  stylix.image = ./wp-neon-city.jpg;
  time.timeZone = "America/Chicago";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
