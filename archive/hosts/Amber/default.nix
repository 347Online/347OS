{
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

  networking.hostName = "Amber";
  time.timeZone = "America/Chicago";

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Astrid = {
        hostname = "192.168.4.110";
        user = username;
        forwardAgent = true;
      };
      Aspen = {
        hostname = "192.168.4.55";
        user = username;
        forwardAgent = true;
      };
    };
  };

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
