{ pkgs, ... }:
{
  extraPlugins = [ pkgs.vimPlugins.leetcode-nvim ];
  extraConfigLua = ''
    require("leetcode.nvim").setup({})
  '';
}
