{
  lib,
  config,
  pkgs,
  util,
  nvim,
  isDarwin,
  ...
}: {
  imports = [
    ./gui
    ./zsh

    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./ledger.nix
    ./less.nix
    ./neomutt.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    _1password
    alejandra
    bat
    eza
    delta
    fd
    mise
    nil
    prettierd
    eslint_d
    ripgrep
    vim
    rustup

    (lib.mkIf config.shared.nixvim.enable nvim)
  ];

  programs = let
    shellAliases = {
      cat = "bat";
      ls = "eza";
      tree = "eza --tree";
      diff = "delta";

      branch =
        # sh
        "git branch --show-current";

      branchhelp =
        # sh
        ''
          git branch --list | rg -v '^\s+?\*|\+' | fzf | awk '{$1=$1};1'
        '';

      nvim-next =
        # sh
        "nix run ~/src/nix-systems#nvim";
    };
  in {
    ssh.enable = true;
    home-manager.enable = true;
    bash.shellAliases = shellAliases;
    zsh.shellAliases = shellAliases;
  };
}
