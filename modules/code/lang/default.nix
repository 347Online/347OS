{lib, ...}: {
  imports = [
    ./java.nix
    ./rust.nix
  ];

  java.enable = lib.mkDefault false;
  rustSetup.enable = lib.mkDefault true;
}
