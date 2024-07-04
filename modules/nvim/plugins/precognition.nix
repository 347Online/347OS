{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    precognition-nvim
  ];

  extraConfigLua =
    /*
    lua
    */
    ''
      require("precognition").setup()
    '';
}
