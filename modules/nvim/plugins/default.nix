{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    delimitMate
  ];

  plugins = {
    telescope.enable = true;
    luasnip.enable = true;
    lualine.enable = true;
    comment.enable = true;
    indent-blankline.enable = true;
    nix.enable = true;
    treesitter = {
      enable = true;
      # indent = true;
    };
  };
}
