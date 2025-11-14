{
  pkgs,
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
    ./mise.nix
    ./pandoc.nix
    ./ssh.nix
    ./syncthing.nix
    ./tealdeer.nix
    ./tmux.nix
    ./zoxide.nix
  ];

  home.packages = with pkgs; [
    _1password-cli
    pre-commit
    sops
    tinty
    yq
  ];

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
      home-manager.enable = true;
      bash.shellAliases = shellAliases;
      zsh.shellAliases = shellAliases;
    };
}
