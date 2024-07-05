{
  util,
  pkgs,
  ...
}: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;

    shellAliases = util.mkShellAliases pkgs;

    initExtraFirst = ''
      # TODO: Rework this config for .zshrc in dotfiles, remove readFile kludge
      # Powerlevel10k Zsh theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
      ${builtins.readFile ./.zshrc}
    '';
  };
}
