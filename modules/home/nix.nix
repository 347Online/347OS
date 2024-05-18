{
  pkgs,
  fenix,
  ...
}: {
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [fenix.overlays.default];

  code.codium.extraExtensions = with pkgs.vscode-extensions; [
    kamadorueda.alejandra
    jnoortheen.nix-ide
  ];

  home.packages = with pkgs; [
    alejandra
    nil
  ];
}
