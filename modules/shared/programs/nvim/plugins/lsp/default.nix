{
  self,
  system,
  ...
}:
{
  imports = [
    ./lspsaga.nix
  ];

  plugins.lsp = {
    enable = true;

    servers = {
      denols.enable = true;
      eslint.enable = true;
      gopls.enable = true;
      html.enable = true;
      lua_ls.enable = true;
      marksman.enable = true;
      nixd = {
        enable = true;
        settings = {
          nixpkgs.expr = "import <nixpkgs> { }";
          formatting.command = [ "nixfmt" ];
          options = {
            linux.expr = "(builtins.getFlake \"${self}\").nixosConfigurations.Aspen.options";
            darwin.expr = "(builtins.getFlake \"${self}\").darwinConfigurations.Athena.options";
            shared.expr = "(builtins.getFlake \"${self}\").packages.${system}.homeConfigurations.katie.options";
          };
        };
      };
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
