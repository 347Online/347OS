{pkgs, ...}: {
  imports = [
    ./lsp

    ./auto-session.nix
    ./cmp.nix
    ./conform-nvim.nix
    ./gitsigns.nix
    ./neo-tree.nix
    ./oil.nix
    ./telescope.nix
  ];

  plugins = {
    nvim-autopairs.enable = true;
    auto-session.enable = true;
    cmp.enable = true;
    conform-nvim.enable = true;
    fugitive.enable = true;
    gitsigns.enable = true;
    indent-blankline.enable = true;
    lualine.enable = true;
    luasnip.enable = true;
    neo-tree.enable = true;
    nix.enable = true;
    oil.enable = true;
    telescope.enable = true;
    treesitter.enable = true;
  };
}
