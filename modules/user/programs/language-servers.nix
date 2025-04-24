{ pkgs, ... }:
{
  home.packages = with pkgs; [
    lua-language-server
    nixd
    typescript-language-server
  ];
}
