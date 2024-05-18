{
  config,
  lib,
  ...
}: {
  options = {
    code.neovim.enable = lib.mkEnableOption "neovim setup";
  };

  config = lib.mkIf config.code.neovim.enable {
    programs.nixvim = {
      enable = true;
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
        oil.enable = true;
        treesitter.enable = true;
        luasnip.enable = true;
        lualine.enable = true;

        lsp = {
          enable = true;
          servers = {
            tsserver.enable = true;
            # lua-ls.enable = true;
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
    };
  };
}
