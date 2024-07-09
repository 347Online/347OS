{
  imports = [
    ./lspsaga.nix
  ];

  plugins.lsp = {
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

  keymaps = [
    {
      mode = "n";
      key = "<leader>r";
      action.__raw = "vim.lsp.buf.rename";
    }
    {
      mode = "n";
      key = "<leader>l";
      action.__raw = "vim.lsp.buf.signature_help";
    }
    {
      mode = "n";
      key = "gd";
      action.__raw = "vim.lsp.buf.definition";
    }
  ];
}
