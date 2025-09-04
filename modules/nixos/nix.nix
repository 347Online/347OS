{
  pkgs,
  config,
  lib,
  nixpkgs,
  username,
  ...
}:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    package = pkgs.nix;
    settings = {
      download-buffer-size = 524288000;
      experimental-features = "nix-command flakes";
      trusted-users = [ username ];
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };
  nixpkgs.config.allowUnfreePredicate =
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
}
