{
  lib,
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

    ./bat.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./lazygit.nix
    ./ledger.nix
    ./neomutt.nix
    ./tmux.nix
    ./wezterm.nix
    ./zoxide.nix
  ];

  options = {
    nvim-setup.enable = lib.mkEnableOption "neovim setup";
  };

  config = {
    nvim-setup.enable = lib.mkDefault true;

    home.packages = with pkgs; [
      _1password
      alejandra
      bat
      eza
      fd
      mise
      nil
      prettierd
      ripgrep
      vim

      (lib.mkIf config.nvim-setup.enable nvim)
    ];

    programs = {
      home-manager.enable = true;
      bash.shellAliases = util.mkShellAliases pkgs;
    };
  };
}
