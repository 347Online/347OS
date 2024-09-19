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
      ts-ls.enable = true;
      jdt-language-server.enable = true;
      lua-ls.enable = true;
      nil-ls.enable = true;
      rust-analyzer = {
        enable = true;
        installRustc = false;
        installCargo = false;

        settings = {
          check.command = "clippy";
        };
      };
    };
  };
}
