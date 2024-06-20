{
  imports = [./bufferline.nix];

  opts = {
    wrap = false;
    number = true;
    relativenumber = true;
    shiftwidth = 2;
    expandtab = true;
  };

  colorschemes.tokyonight.enable = true;

  plugins = {
    telescope.enable = true;
    treesitter.enable = true;
    luasnip.enable = true;
    lualine.enable = true;
    comment.enable = true;

    neo-tree = {
      enable = true;

      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = true;
      };
    };

    lsp = {
      enable = true;
      servers = {
        tsserver.enable = true;
        lua-ls.enable = true;
        rust-analyzer = {
          enable = true;
          installRustc = false;
          installCargo = false;
        };
      };
    };

    cmp = {
      enable = true;
      settings = {
        sources = [
          {name = "nvim_lsp";}
          {name = "path";}
          {name = "buffer";}
        ];

        autoEnableSources = true;

        mapping = {
          "<CR>" = "cmp.mapping.confirm({ select = true })";
          "<S-Tab>" = "cmp.mapping(cmp.mapping.select_prev_item(), {'i', 's'})";
          "<Tab>" = "cmp.mapping(cmp.mapping.select_next_item(), {'i', 's'})";
        };
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>n";
      action = ":Neotree action=focus reveal toggle<CR>";
      options.silent = true;
    }
  ];
}
