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
    gui.enable = true;
    personal.enable = true;
  };

  networking.hostName = "Arctic";
  time.timeZone = "America/Chicago";

  hardware.asahi.peripheralFirmwareDirectory = ./firmware;

  services.libinput = {
    enable = true;
    touchpad.disableWhileTyping = true;
  };

  # DO NOT EDIT
  system.stateVersion = "25.11";
}
