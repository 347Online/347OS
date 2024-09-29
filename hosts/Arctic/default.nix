{username, ...}: {
  imports = [
    ./hardware.nix
  ];

  stylix.image = ./wp-neon-city.jpg;
  games.enable = true;
  boot.binfmt.emulatedSystems = ["x86_64-linux"];

  networking.hostName = "Arctic";
  time.timeZone = "America/Chicago";

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Arukenia = {
        hostname = "konundream.com";
        user = username;
        port = 5892;
      };
    };
  };

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
