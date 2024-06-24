{
  imports = [
    ./codium
    ./zsh
    ./git.nix
  ];

  programs.home-manager.enable = true;
  programs.fzf.enable = true;
}
