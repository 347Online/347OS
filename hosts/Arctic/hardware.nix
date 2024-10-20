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
    device = "/dev/disk/by-uuid/d51b45f0-42c9-465e-b1ce-8c7a89466882";
    fsType = "ext4";
  };

  fileSystems."/boot" = {
    device = "/dev/disk/by-uuid/C947-1E08";
    fsType = "vfat";
    options = ["fmask=0022" "dmask=0022"];
  };

  swapDevices = [{device = "/.swap";}];

  networking.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
}
