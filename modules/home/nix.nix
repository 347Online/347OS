{
  pkgs,
  fenix,
  nur,
  ...
}: {
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];
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

  code.codium.extraExtensions = with pkgs.vscode-extensions; [
    kamadorueda.alejandra
    jnoortheen.nix-ide
  ];

  home.packages = with pkgs; [
    alejandra
    nil
  ];
}
