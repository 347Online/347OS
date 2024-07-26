{
  pkgs,
  util,
  nvim,
  lib,
  config,
  isDarwin,
  ...
}: {
  imports = [
    ./codium
    ./firefox
    ./zsh

    ./direnv.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
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
    prettierd

    # TODO: Remove obsidian altogether
    (lib.mkIf ((!config.linux.headless) or isDarwin) obsidian) #TODO: only if darwin or a gui

    nvim
  ];

  programs.home-manager.enable = true;

  programs.bash.shellAliases = util.mkShellAliases pkgs;
}
