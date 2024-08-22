{lib, ...}: let
  extraConfigLua =
    lib.mkBefore
    /*
    lua
    */
    ''
      local function first(bufnr, ...)
        local conform = require("conform")
        for i = 1, select("#", ...) do
          local formatter = select(i, ...)
          if conform.get_formatter_info(formatter, bufnr).available then
            return formatter
          end
        end
        return select(1, ...)
      end
    '';

  prettier =
    /*
    lua
    */
    ''
      function(bufnr)
        return first(bufnr, "prettierd", "prettier")
      end
    '';
  prettier-eslint =
    /*
    lua
    */
    ''
      function(bufnr)
          return { first(bufnr, "prettierd", "prettier"), "eslint_d" }
      end
    '';
in {
  inherit extraConfigLua;
  plugins.conform-nvim = {
    enable = true;

    formatOnSave = {
      lspFallback = true;
      timeoutMs = 500;
    };

    notifyOnError = true;
    formattersByFt = {
      html.__raw = prettier;
      css.__raw = prettier;
      markdown.__raw = prettier;

      json.__raw = prettier-eslint;
      jsonc.__raw = prettier-eslint;
      javascript.__raw = prettier-eslint;
      javascriptreact.__raw = prettier-eslint;
      typescript.__raw = prettier-eslint;
      typescriptreact.__raw = prettier-eslint;

      lua = ["stylua"];
      nix = ["alejandra"];
      yaml = ["yamllint" "yamlfmt"];
    };
  };
}
