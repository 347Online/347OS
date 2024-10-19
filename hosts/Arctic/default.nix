{username, ...}: {
  imports = [
    ./hardware.nix
  ];

  stylix.image = ./wp-neon-city.jpg;

  networking.hostName = "Arctic";
  time.timeZone = "America/Chicago";

  linux.gaming.enable = true;
  linux.gui.enable = true;

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Arukenia = {
        hostname = "konundream.com";
        user = username;
        port = 5892;
      };
    };
  };

  # Enables cross-build to Intel systems
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
