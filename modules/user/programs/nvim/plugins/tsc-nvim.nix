{ pkgs, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    tsc-nvim
  ];

  extraConfigLua = ''
    require("tsc").setup()
  '';
}
