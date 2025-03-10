{
  lib,
  config,
  pkgs,
  nvim,
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
      sops

      (lib.mkIf config.user.nixvim.enable nvim)
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

        journal =
          # bash
          ''
            nvim "${homeDirectory}/Sync/Notes/journal/$(date +%Y-%m-%d).md"
          '';

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
