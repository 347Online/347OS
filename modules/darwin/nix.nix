{
  pkgs,
  inputs,
  ...
}:
{
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
