{ pkgs, ... }:
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    initExtraFirst =
      # sh
      ''
        # TODO: Rework this config for .zshrc in dotfiles, remove readFile kludge
        # TODO: Remove Powerlevel10k in favor of oh my posh or similar
        # Powerlevel10k Zsh theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        ${builtins.readFile ./.zshrc}
      '';
  };
}
