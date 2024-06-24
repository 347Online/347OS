{
  pkgs,
  fenix,
  nur,
  ...
}: {
  nixpkgs = {
    overlays = [fenix.overlays.default];
    config = {
      allowUnfree = true;
      packageOverrides = pkgs: {
        inherit nur;
        # nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
        #   inherit pkgs;
        # };
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
