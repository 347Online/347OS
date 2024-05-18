{lib, ...}: {
  imports = [
    ./java.nix
    ./nodejs.nix
    ./python.nix
    ./rust.nix
  ];

  lang = {
    java.enable = lib.mkDefault false;
    nodejs.enable = lib.mkDefault true;
    python.enable = lib.mkDefault true;
    rust.enable = lib.mkDefault true;
  };
}
