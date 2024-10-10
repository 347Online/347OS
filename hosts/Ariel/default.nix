{
  username,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
  ];

  environment.systemPackages = with pkgs; [aria2];

  services.qemuGuest.enable = true;
  services.spice-vdagentd.enable = true;

  stylix.image = ./wp-desert.jpg;

  linux.headless.enable = true;

  home-manager.users.${username} = {
    programs.ssh.matchBlocks = {
      Arukenia = {
        hostname = "konundream.com";
        user = username;
        port = 5892;
      };
    };
  };

  networking.hostName = "Ariel";
  time.timeZone = "America/Los_Angeles";

  # DO NOT EDIT
  system.stateVersion = "24.11";
}
