{
  pkgs,
  fenix,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [fenix.overlays.default];

  home.packages = with pkgs; [
    alejandra
    nil
  ];
}
