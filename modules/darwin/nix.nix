{
  nixpkgs,
  pkgs,
  ...
}:
{
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      download-buffer-size = 524312500;
    };
    nixPath = [ "nixpkgs=${nixpkgs}" ];
  };
}
