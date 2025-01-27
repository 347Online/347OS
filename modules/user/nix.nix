{
  pkgs,
  nur,
  inputs,
  ...
}:
{
  nix = {
    registry = {
      nixpkgs.flake = inputs.nixpkgs;
      nixos-hardware.flake = inputs.nixos-hardware;
    };
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    nixPath = [ "nixpkgs=${inputs.nixpkgs}" ];
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
