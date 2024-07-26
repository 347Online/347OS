{pkgs, ...}: {
  nix = {
    package = pkgs.nix;
    settings = {
      experimental-features = "nix-command flakes";
      trusted-users = ["katie" "root"];
    };
  };

  nixpkgs = {
    config.allowUnfree = true;
  };
}
