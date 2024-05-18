{pkgs, ...}: {
  services.nix-daemon.enable = true;

  nix = {
    package = pkgs.nix;
    settings.experimental-features = "nix-command flakes";
  };

  nixpkgs = {
    hostPlatform = "aarch64-darwin";
    config.allowUnfree = true;
  };
}
