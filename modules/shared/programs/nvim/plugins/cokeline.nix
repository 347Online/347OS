{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    nvim-cokeline
  ];

  extraConfigLua =
    /*
    lua
    */
    ''
      require("cokeline").setup()
    '';
}
