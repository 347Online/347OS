{
  config,
  pkgs,
  util,
  nvim,
  ...
}: {
  imports = [
    ./codium
    ./firefox
    ./zsh

    ./alacritty.nix
    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    bat
    eza
    ripgrep
    fd
    mise
    _1password
    prettierd

    obsidian

    # (nvim.extend {colorschemes.base16 = config.programs.nixvim.colorschemes.base16;})
    nvim
  ];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
