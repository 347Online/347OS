{pkgs, ...}: {
  imports = [
    ./cmp.nix
    ./conform.nix
    ./gitsigns.nix
    ./lsp.nix
    ./neo-tree.nix
  ];

  extraPlugins = with pkgs.vimPlugins; [
    delimitMate
    {
      plugin = precognition-nvim;
      config = ''
        lua require("Precognition").setup()
      '';
    }
  ];

  globals = {
    delimitMate_expand_cr = true;
    delimitMate_expand_inside_quotes = true;
    delimitMate_autoclose = false;
  };

  plugins = {
    bufferline.enable = true;
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
