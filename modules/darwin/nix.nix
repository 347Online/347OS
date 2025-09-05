{
  system,
  nixpkgs,
  config,
  lib,
  username,
  experimental-features,
  ...
}:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    settings = {
      inherit experimental-features;
      trusted-users = [ username ];
      download-buffer-size = 524312500;
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };

  nixpkgs = {
    hostPlatform = system;
    config.allowUnfreePredicate =
      pkg: builtins.elem (lib.getName pkg) (config.darwin.unfree-allowed ++ [ "ookla-speedtest" ]);
  };
}
