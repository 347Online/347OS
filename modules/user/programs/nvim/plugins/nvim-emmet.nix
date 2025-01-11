{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [ nvim-emmet ];
}
