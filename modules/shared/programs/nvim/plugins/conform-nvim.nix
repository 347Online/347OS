{
  plugins.conform-nvim = {
    enable = true;

    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };
    notifyOnError = true;
    formattersByFt = {
      html = [["prettierd" "prettier"]];
      css = [["prettierd" "prettier"]];
      json = [["prettierd" "prettier"] "eslint_d"];
      jsonc = [["prettierd" "prettier"] "eslint_d"];
      javascript = [["prettierd" "prettier"] "eslint_d"];
      javascriptreact = [["prettierd" "prettier"] "eslint_d"];
      typescript = [["prettierd" "prettier"] "eslint_d"];
      typescriptreact = [["prettierd" "prettier"] "eslint_d"];
      lua = ["stylua"];
      nix = ["alejandra"];
      markdown = [["prettierd" "prettier"]];
      yaml = ["yamllint" "yamlfmt"];
    };
  };
}
