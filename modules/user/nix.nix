{
  nixpkgs,
  inputs,
  lib,
  ...
}:
{
  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs-unstable;
      nixos-hardware.flake = inputs.nixos-hardware;
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "1password-cli"
      "discord"
      "ookla-speedtest"
      "onepassword-password-manager"
      "teamtalk5"
      "vscode-extension-ms-vsliveshare-vsliveshare"
    ];
}
