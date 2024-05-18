{pkgs, ...}: {
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin"; # TODO: Consider also enabling intel as an option
    config.allowUnfree = true;
  };
}
