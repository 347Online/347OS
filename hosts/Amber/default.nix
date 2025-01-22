{
  self,
  username,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixos = {
    gaming.enable = true;
    gui.enable = true;
    personal.enable = true;
  };

  stylix.image = "${self}/wallpapers/neon-city.jpg";

  networking.hostName = "Amber";
  time.timeZone = "America/Chicago";

  users.users.${username} = {
    extraGroups = [ "networkmanager" ];
  };

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Astrid = {
        hostname = "192.168.4.110";
        user = username;
        forwardAgent = true;
      };
      Aspen = {
        hostname = "fatgirl.cloud";
        user = username;
        port = 5892;
        forwardAgent = true;
      };
    };
  };

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
