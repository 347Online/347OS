{ inputs, ... }:
{
  flake.variables = {
    defaultUsername = "katie";

    experimental-features = [
      "nix-command"
      "flakes"
      # "pipe-operators"
      "pipe-operator"
    ];

    overlays = [
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlays.default
      inputs.ghostty.overlays.default
      inputs.lix-module.overlays.default
      # TODO: Fix the overlay in kclip-cli package
      (final: prev: { kclip-cli = inputs.kclip.packages.${prev.system}.default; })
    ];
  };
}
