{
  system,
  nixpkgs,
  pkgs,
  lib,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      download-buffer-size = 524312500;
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) [
        "ookla-speedtest"
      ];
  };
}
