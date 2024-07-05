{inputs, ...}: {
  imports = [
    inputs.apple-silicon-support.nixosModules.apple-silicon-support
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = false;
  boot.kernelParams = ["apple_dcp.show_notch=1"];

  hardware.asahi.setupAsahiSound = true;
  hardware.asahi.useExperimentalGPUDriver = true;
  hardware.asahi.extractPeripheralFirmware = true;
  hardware.asahi.peripheralFirmwareDirectory = ./firmware;
  hardware.asahi.experimentalGPUInstallMode = "overlay";
}
