{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lua-language-server
    nixd
    taplo-lsp
    typescript-language-server
    vscode-langservers-extracted
  ];
}
