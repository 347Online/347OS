{
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./java.nix
    ./nodejs.nix
    ./python.nix
    ./rust.nix
  ];

  code = {
    java.enable = lib.mkDefault false;
    rust.enable = lib.mkDefault true;
  };

  home.packages = with pkgs; [
    nodejs
    python3
  ];
}
