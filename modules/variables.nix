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
      inputs.nix-vscode-extensions.overlays.default
      inputs.nur.overlays.default
      inputs.ghostty.overlays.default
      inputs.kclip.overlays.default
    ];
  };
}
