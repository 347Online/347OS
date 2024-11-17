{
  imports = [
    ./lspsaga.nix
  ];

  plugins.lsp = {
    enable = true;

    servers = {
      eslint.enable = true;
      html.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nil_ls.enable = true;
      ts_ls.enable = true;
      rust_analyzer = {
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
