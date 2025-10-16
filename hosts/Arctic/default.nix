{
  username,
  lib,
  ...
}:
{
  imports = [
    ./hardware-configuration.nix
  ];

  nixos = {
    # gaming.enable = true;
    gui.enable = true;
    personal.enable = true;
  };

  networking.hostName = "Arctic";
  time.timeZone = "America/Chicago";

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  # DO NOT EDIT
  system.stateVersion = "25.11";
}
