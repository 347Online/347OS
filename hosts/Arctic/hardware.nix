{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  imports = [
    ./asahi.nix
    (modulesPath + "/installer/scan/not-detected.nix")
  ];

  services.libinput.enable = true;

  hardware.bluetooth.enable = true;

  networking.wireless.iwd = {
    enable = true;
    settings.General.EnableNetworkConfiguration = true;
  };

  # DO NOT EDIT
  boot.initrd.availableKernelModules = ["usbhid" "usb_storage" "sdhci_pci"];
  boot.initrd.kernelModules = [];
  boot.kernelModules = [];
  boot.extraModulePackages = [];

  fileSystems."/" = {
    device = "/dev/disk/by-uuid/b731d3b8-7758-4256-baef-89b1560482a4";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/51A6-1AFB";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
