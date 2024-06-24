{pkgs, ...}: {
  extraPlugins = with pkgs.vimPlugins; [
    delimitMate
  ];

  plugins = {
    telescope.enable = true;
    treesitter = {
      enable = true;
      # indent = true;
    };
    luasnip.enable = true;
    lualine.enable = true;
    comment.enable = true;
    indent-blankline.enable = true;
    nix.enable = true;

    gitsigns = {
      enable = true;
      settings = {
        current_line_blame = true;
      };
    };

    conform-nvim = {
      enable = true;
      formatOnSave = {
        lspFallback = true;
        timeoutMs = 500;
      };
      notifyOnError = true;
      formattersByFt = {
        liquidsoap = ["liquidsoap-prettier"];
        html = [["prettierd" "prettier"]];
        css = [["prettierd" "prettier"]];
        javascript = [["prettierd" "prettier"]];
        javascriptreact = [["prettierd" "prettier"]];
        typescript = [["prettierd" "prettier"]];
        typescriptreact = [["prettierd" "prettier"]];
        lua = ["stylua"];
        nix = ["alejandra"];
        markdown = [["prettierd" "prettier"]];
        yaml = ["yamllint" "yamlfmt"];
      };
    };

    neo-tree = {
      enable = true;

      filesystem = {
        filteredItems = {
          visible = true;
          hideDotfiles = false;
          hideGitignored = true;
          neverShow = [
            ".git"
          ];
        };
      };

      enableDiagnostics = true;
      enableGitStatus = true;
      enableModifiedMarkers = true;
      enableRefreshOnWrite = true;
      closeIfLastWindow = true;
      window = {
        width = 30;
        autoExpandWidth = false;
      };
    };

    lsp = {
      enable = true;
      servers = {
        eslint.enable = true;
        html.enable = true;
        marksman.enable = true;
        tsserver.enable = true;
        lua-ls.enable = true;
        nil-ls.enable = true;
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
        experimental.ghost_text = true;
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
}
