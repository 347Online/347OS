{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash-language-server
    lua-language-server
    nixd
    taplo-lsp
    typescript-language-server
    vscode-langservers-extracted
  ];
}
