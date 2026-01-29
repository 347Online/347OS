{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash-language-server
    jinja-lsp
    lua-language-server
    nixd
    sqls
    taplo
    typescript-language-server
    vscode-langservers-extracted
  ];
}
