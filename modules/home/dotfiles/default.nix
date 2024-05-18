{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {};

  config =
    {
      home.file.".hushlogin".text = "";
    }
    // (lib.mkIf config.code.shell.enable {
      home.file.".config/zsh/.p10k.zsh".source = ./.config/zsh/.p10k.zsh;

      programs.zsh.initExtraFirst = ''
        # Powerlevel10k Zsh theme
        source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme
        ${builtins.readFile ./dotfiles/.zshrc}
      '';
    });
}
