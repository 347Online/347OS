{nixvim, ...}: {
  imports = [
    ./vscode
    ./shell.nix
    ./git.nix

    nixvim
    ./neovim.nix
  ];
}
