{
  pkgs,
  lib,
  flakeDir,
  ...
}:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initContent = lib.mkMerge [
      (lib.mkBefore ''
        # Powerlevel10k Zsh theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        export FLAKE_DIR="${flakeDir}"
      '')
      (lib.mkAfter (builtins.readFile ./.zshrc))
    ];
  };
}
