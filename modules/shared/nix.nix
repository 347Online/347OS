{
  pkgs,
  fenix,
  nur,
  inputs,
  ...
}: {
  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      nixos-hardware.flake = inputs.nixos-hardware;
    };
    settings = {
      trusted-users = ["katie" "root"];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  nixpkgs = {
    overlays = [fenix.overlays.default];
    config = {
      allowUnfree = true;
      allowUnsupportedSystem = true;
      packageOverrides = pkgs: {
        inherit nur;
      };
    };
  };
}
