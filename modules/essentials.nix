let
  mkEssentials =
    pkgs: with pkgs; [
      bat
      coreutils
      eza
      delta
      direnv
      fd
      fzf
      git
      go
      htop
      moreutils
      neovim
      nixfmt-rfc-style
      nix-search-cli
      nodejs
      ookla-speedtest
      python3
      ripgrep
      rustup
      trunk
      screen
      shellcheck
      tmux
      zoxide
    ];
in
{
  flake = {
    homeModules.essentials =
      { pkgs, ... }:
      {
        home.packages = mkEssentials pkgs;
      };
    darwinModules.essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = mkEssentials pkgs;
      };
    nixosModules.essentials =
      { pkgs, ... }:
      {
        environment.systemPackages = mkEssentials pkgs;
      };
  };
}
