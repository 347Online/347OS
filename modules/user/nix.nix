{
  nixpkgs,
  inputs,
  lib,
  ...
}:
{
  nix = {
    gc = {
      automatic = true;
      options = "--delete-older-than 30d";
    };
    registry = {
      nixpkgs.flake = inputs.nixpkgs-unstable;
      nixos-hardware.flake = inputs.nixos-hardware;
    };
    settings = {
      download-buffer-size = 524288000;
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
