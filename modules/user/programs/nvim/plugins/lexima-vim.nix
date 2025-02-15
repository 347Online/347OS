{ pkgs, ... }:
{
  extraPlugins = with pkgs; [ vimPlugins.lexima-vim ];
  extraConfigVim = "let g:lexima_enable_basic_rules = 0";
}
