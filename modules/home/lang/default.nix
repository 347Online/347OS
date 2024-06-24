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

  lang = {
    rust = {
      vscodeExtension = lib.mkDefault true;
    };
  };

  home.packages = with pkgs; [
    rtx
  ];
}
