{ lib, ... }:
rec {
  extraConfigLua =
    lib.mkIf (plugins.conform-nvim.enable or false)
      # lua
      ''
        vim.api.nvim_create_user_command(
          "FormatDisable",
          function(args)
            if args.bang then
              vim.b.disable_autoformat = true
            else
              vim.g.disable_autoformat = true
            end
          end,
          {
            desc = "Disable autoformat-on-save",
            bang = true
          }
        )
        vim.api.nvim_create_user_command(
          "FormatEnable",
          function()
            vim.b.disable_autoformat = false
            vim.g.disable_autoformat = false
          end,
          {
            desc = "Re-enable autoformat-on-save"
          }
        )
      '';

  plugins.conform-nvim = {
    enable = true;

    settings = {
      format_on_save.__raw = ''
        function(bufnr)
          if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
            return
          end

          return {
            timeout_ms = 750, lsp_fallback = true
          }
        end
      '';

      notify_on_error = true;

      formatters_by_ft = {
        html = [ "prettierd" ];
        css = [ "prettierd" ];
        markdown = [ "prettierd" ];

        json = [
          "prettierd"
          "eslint_d"
        ];
        jsonc = [
          "prettierd"
          "eslint_d"
        ];
        javascript = [
          "prettierd"
          "eslint_d"
        ];
        javascriptreact = [
          "prettierd"
          "eslint_d"
        ];
        typescript = [
          "prettierd"
          "eslint_d"
        ];
        typescriptreact = [
          "prettierd"
          "eslint_d"
        ];

        lua = [ "stylua" ];
        nix = [ "nixfmt" ];
        yaml = [
          "yamllint"
          "yamlfmt"
        ];
      };
    };
  };
}
