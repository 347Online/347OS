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
    precognition-nvim
  ];

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
