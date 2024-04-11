{
  pkgs,
  hostPlatform,
  ...
}: {
  nixpkgs.hostPlatform = hostPlatform;

  services.nix-daemon.enable = true;
  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };
}
