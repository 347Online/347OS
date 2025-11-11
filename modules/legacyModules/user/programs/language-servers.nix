{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bash-language-server
    jinja-lsp
    lua-language-server
    nixd
    sqls
    taplo-lsp
    typescript-language-server
    vscode-langservers-extracted
  ];
}
