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
  };
}
