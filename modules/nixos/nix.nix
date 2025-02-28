{
  pkgs,
  lib,
  nixpkgs,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    settings = {
      download-buffer-size = 524288000;
      experimental-features = "nix-command flakes";
      trusted-users = [ "katie" ];
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };
  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password"
      "1password-cli"
      "ookla-speedtest"
      "steam"
      "steam-unwrapped"
    ];
}
