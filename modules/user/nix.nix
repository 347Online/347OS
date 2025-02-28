{
  nixpkgs,
  nur,
  inputs,
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
  nixpkgs = {
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        inherit nur;
      };
    };
  };
}
