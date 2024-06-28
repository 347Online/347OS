{pkgs, ...}: {
  imports = [
    ./cokeline.nix
    ./completion.nix
    ./formatting.nix
    ./filetree.nix
    ./git.nix
    ./lsp.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    delimitMate
    precognition-nvim
  ];

  extraConfigLua =
    /*
    lua
    */
    ''
      require("Precognition").setup()
      require("cokeline").setup()
    '';

  globals = {
    delimitMate_expand_cr = true;
    delimitMate_expand_inside_quotes = true;
    delimitMate_autoclose = false;
  };

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
