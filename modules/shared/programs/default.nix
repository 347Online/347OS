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
    ./wezterm.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    alejandra
    nil
    bat
    eza
    ripgrep
    fd
    mise
    _1password # TODO: Attempt to fix and contribute upstream
    prettierd

    obsidian

    # (nvim.extend {colorschemes.base16 = config.programs.nixvim.colorschemes.base16;})
    nvim
  ];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
