{
  nixpkgs,
  inputs,
  config,
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
      nixpkgs.flake = inputs.nixpkgs;
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
    builtins.elem (lib.getName pkg) (
      config.user.unfree-allowed
      ++ [
        "1password-cli"
        "discord"
        "ookla-speedtest"
        "onepassword-password-manager"
        "teamtalk5"
        "vscode-extension-ms-vsliveshare-vsliveshare"
      ]
    );
}
