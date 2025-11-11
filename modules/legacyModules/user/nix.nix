{
  inputs,
  config,
  lib,
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
    registry.nixpkgs.flake = inputs.nixpkgs;
    settings = {
      inherit experimental-features;
      # download-buffer-size = 524288000;
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    inherit overlays;
    config.allowUnfreePredicate =
      pkg:
      builtins.elem (lib.getName pkg) (
        config.user.unfree-allowed
        ++ [
          "1password"
          "1password-cli"
          "discord"
          "instapaper-official"
          "onepassword-password-manager"
          "ookla-speedtest"
          "zoom"
        ]
      );
  };
}
