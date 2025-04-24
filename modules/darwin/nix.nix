{
  system,
  nixpkgs,
  pkgs,
  lib,
  username,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      trusted-users = [ username ];
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
