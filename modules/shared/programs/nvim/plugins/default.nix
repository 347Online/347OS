{pkgs, ...}: {
  imports = [
    ./lsp

    ./autopairs.nix
    ./cokeline.nix
    ./completion.nix
    ./formatting.nix
    ./git.nix
    ./neo-tree.nix
    ./telescope.nix
  ];

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
