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
      ts_ls.enable = true;
      jdtls.enable = true;
      lua_ls.enable = true;
      # nil_ls.enable = true;
      nixd = {
        enable = true;

        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
        };
      };
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
