{
  inputs,
  config,
  lib,
  username,
  experimental-features,
  overlays,
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
      download-buffer-size = 524288000;
      trusted-users = [ username ];
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    inherit overlays;
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) (
        config.nixos.unfree-allowed
        ++ [
          "1password"
          "1password-cli"
          "minecraft-server"
          "ookla-speedtest"
          "plexmediaserver"
          "steam"
          "steam-unwrapped"
        ]
      );
  };
}
