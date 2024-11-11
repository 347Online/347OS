{
  lib,
  config,
  pkgs,
  nvim,
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
    ./jq.nix
    ./lazygit.nix
    ./ledger.nix
    ./less.nix
    ./neomutt.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
    alejandra
    bat
    eslint_d
    eza
    delta
    fd
    mise
    moreutils
    nil
    nix-search-cli
    prettierd
    ripgrep
    rustup
    vim

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
