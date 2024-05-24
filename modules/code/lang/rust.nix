{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    lang.rust = {
      enable = lib.mkEnableOption "rust setup";
      toolchain = lib.mkOption {
        type = lib.types.enum ["stable" "beta" "nightly"];
        default = "stable";
      };
    };
  };

  config = lib.mkIf config.lang.rust.enable {
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

    code.codium.extraExtensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer-nightly
    ];
  };
}
