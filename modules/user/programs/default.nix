{
  lib,
  config,
  pkgs,
  homeDirectory,
  flakeDir,
  ...
}:
{
  imports = [
    ./gui
    ./zsh

    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./formatters.nix
    ./fzf.nix
    ./git.nix
    ./jq.nix
    ./language-servers.nix
    ./lazygit.nix
    ./ledger.nix
    ./less.nix
    ./pandoc.nix
    ./syncthing.nix
    ./tealdeer.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages =
    let
      essentials = (import ./essentials.nix pkgs);
    in
    with pkgs;
    [
      _1password-cli
      mise
      pre-commit
      sops
      tinty
      yq
    ]
    ++ essentials;

  programs =
    let
      # TODO: Move to scripts
      shellAliases = {
        cat = "bat";
        ls = "eza";
        tree = "eza --tree";
        diff = "delta";
        gg = "lazygit";
        vi = "nvim";
        vim = "nvim";

        branch =
          # sh
          "git branch --show-current";

        branchhelp =
          # sh
          ''
            git branch --list | rg -v '^\s+?\*|\+' | fzf | awk '{$1=$1};1'
          '';
      };
    in
    {
      ssh.enable = true;
      home-manager.enable = true;
      bash.shellAliases = shellAliases;
      zsh.shellAliases = shellAliases;
    };
}
