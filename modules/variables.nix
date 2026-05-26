{ inputs, ... }:
{
  flake.variables = {
    defaultUsername = "katie";

    experimental-features = [
      "nix-command"
      "flakes"
      "pipe-operators"
    ];

    overlays = [
      (final: prev: rec {
        unstable = import inputs.nixpkgs-unstable {
          system = final.system;
          config.allowUnfree = true;
        };
        inherit (unstable) ruby_4_0;
      })
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlays.default
      inputs.ghostty.overlays.default
      inputs.kclip.overlays.default
    ];
  };
}
