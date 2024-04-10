{
  pkgs,
  nix-minecraft,
  ...
}: {
  home.packages = with pkgs; [
    prismlauncher
  ];

  # TODO: Expand this
}
