{
  pkgs,
  util,
  nvim,
  ...
}: {
  imports = [
    ./codium
    ./firefox
    ./zsh

    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./ledger.nix
    ./neomutt.nix
    ./tmux.nix
    ./wezterm.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    _1password
    alejandra
    bat
    eza
    fd
    mise
    nil
    prettierd
    ripgrep

    # TODO: Use standalone nixvim for standalone config
    # Use programs.nixvim = eval config // {enable = true;}
    nvim
  ];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
