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
  ];

  programs.home-manager.enable = true;
  programs.fzf.enable = true;

  programs.shellAliases = util.mkShellAliases pkgs;
}
