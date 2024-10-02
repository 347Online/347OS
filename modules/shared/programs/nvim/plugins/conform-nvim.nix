{
  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save = {
        lsp_fallback = true;
        timeout_ms = 750;
      };

      notify_on_error = true;

      formatters_by_ft = {
        html = ["prettierd"];
        css = ["prettierd"];
        markdown = ["prettierd"];

        json = ["prettierd" "eslint_d"];
        jsonc = ["prettierd" "eslint_d"];
        javascript = ["prettierd" "eslint_d"];
        javascriptreact = ["prettierd" "eslint_d"];
        typescript = ["prettierd" "eslint_d"];
        typescriptreact = ["prettierd" "eslint_d"];

        lua = ["stylua"];
        nix = ["alejandra"];
        yaml = ["yamllint" "yamlfmt"];
      };
    };
  };
}
