{
  pkgs,
  util,
  nvim,
  ...
}: {
  imports = [
    ./codium
    ./zsh

    ./alacritty.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = [nvim];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
