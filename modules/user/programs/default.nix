{
  lib,
  config,
  pkgs,
  nvim,
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
    ./fzf.nix
    ./git.nix
    ./jq.nix
    ./lazygit.nix
    ./ledger.nix
    ./less.nix
    ./neomutt.nix
    ./pandoc.nix
    ./syncthing.nix
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
      eslint_d
      mdformat
      prettierd
      sops
      yamlfmt
      yamllint

      (lib.mkIf config.user.nixvim.enable nvim)
    ]
    ++ essentials;

  programs =
    let
      shellAliases = {
        cat = "bat";
        ls = "eza";
        tree = "eza --tree";
        diff = "delta";
        gg = "lazygit";

        branch =
          # bash
          "git branch --show-current";

        branchhelp =
          # bash
          ''
            git branch --list | rg -v '^\s+?\*|\+' | fzf | awk '{$1=$1};1'
          '';

        nvim-next =
          # bash
          "nix run ${flakeDir}#nvim";
      };
    in
    {
      ssh.enable = true;
      home-manager.enable = true;
      bash.shellAliases = shellAliases;
      zsh.shellAliases = shellAliases;
    };
}
