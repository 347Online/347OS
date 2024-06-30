{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    lang.rust.toolchain = lib.mkOption {
      type = lib.types.enum ["stable" "beta" "nightly"];
      default = "stable";
    };
  };

  config = {
    home.packages = with pkgs; [
      (fenix.${config.lang.rust.toolchain}.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
    ];

    code.codium.extraExtensions = with pkgs.vscode-extensions;
      lib.mkIf config.code.codium.rust [
        # rust-lang.rust-analyzer-nightly
      ];
  };
}
