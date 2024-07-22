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

    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
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
    _1password
    prettierd

    obsidian #TODO: only if darwin or a gui

    # (nvim.extend {colorschemes.base16 = config.programs.nixvim.colorschemes.base16;})
    nvim
  ];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
