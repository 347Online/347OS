{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    rustSetup = {
      enable = lib.mkEnableOption "rust setup";
      toolchain = lib.mkOption {
        # TODO: Figure out how to make one of stable, beta, or nightly
        type = lib.types.str;
        default = "stable";
      };
    };
  };

  config = lib.mkIf config.rustSetup.enable {
    home.packages = with pkgs; [
      (fenix.${config.rustSetup.toolchain}.withComponents [
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
