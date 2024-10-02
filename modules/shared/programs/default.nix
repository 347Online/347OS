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
    ./neomutt.nix
    ./tmux.nix
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
    ssh = {
      enable = true;
      # TODO: Consider disabling if headless
      extraConfig =
        util.mkIfElse isDarwin ''IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'' "IdentityAgent ~/.1password/agent.sock";
    };
    home-manager.enable = true;
    bash.shellAliases = shellAliases;
    zsh.shellAliases = shellAliases;
  };
}
