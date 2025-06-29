{
  self,
  username,
  ...
}:
{
  imports = [
    ./hardware.nix
  ];

  networking.hostName = "Arctic";
  time.timeZone = "America/Chicago";

  nixos.gaming.enable = true;
  nixos.gui.enable = true;

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Aspen = {
        hostname = "fatgirl.cloud";
        user = username;
        port = 5892;
      };
    };
  };

  # Enables cross-build to Intel systems
  boot.binfmt.emulatedSystems = [ "x86_64-linux" ];

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
