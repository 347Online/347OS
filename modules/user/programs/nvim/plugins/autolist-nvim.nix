{ pkgs, lib, ... }:
{
  extraPlugins = with pkgs.vimPlugins; [
    autolist-nvim
  ];

  extraConfigLua =
    lib.mkAfter
      # lua
      ''
        require("autolist").setup()
      '';
}
