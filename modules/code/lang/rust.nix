{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    code.rust = {
      enable = lib.mkEnableOption "rust setup";
      toolchain = lib.mkOption {
        type = lib.types.oneOf [
          "stable"
          "beta"
          "nightly"
        ];
        default = "stable";
      };
    };
  };

  config = lib.mkIf config.code.rust.enable {
    home.packages = with pkgs; [
      (fenix.${config.code.rust.toolchain}.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
      rust-analyzer-nightly
    ];
  };
}
