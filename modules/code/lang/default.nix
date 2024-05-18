{lib, ...}: {
  imports = [
    ./java.nix
    ./rust.nix
  ];

  code = {
    java.enable = lib.mkDefault false;
    rust.enable = lib.mkDefault true;
  };
}
