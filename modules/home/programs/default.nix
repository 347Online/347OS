{
  pkgs,
  util,
  ...
}: {
  imports = [
    ./codium
    ./zsh

    ./alacritty.nix
    ./git.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  programs.home-manager.enable = true;
  programs.fzf.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
