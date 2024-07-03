{pkgs, ...}: {
  imports = [
    ./actions-preview.nix
    ./cokeline.nix
    ./completion.nix
    ./formatting.nix
    ./git.nix
    ./lsp.nix
    ./neo-tree.nix
    ./telescope.nix
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
      require("precognition").setup()
      require("cokeline").setup()
    '';

  globals = {
    delimitMate_expand_cr = true;
    delimitMate_expand_inside_quotes = true;
    delimitMate_autoclose = false;
    delimitMate_balance_matchpairs = false;
  };

  plugins = {
    luasnip.enable = true;
    lualine.enable = true;
    indent-blankline.enable = true;
    nix.enable = true;
    treesitter = {
      enable = true;
    };
  };
}
