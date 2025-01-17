{
  system,
  flakeDir,
  ...
}:
{
  imports = [
    ./lspsaga.nix
  ];

  plugins.lsp = {
    enable = true;

    servers = {
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
            nixos.expr = "(builtins.getFlake \"${flakeDir}\").nixosConfigurations.Aspen.options";
            darwin.expr = "(builtins.getFlake \"${flakeDir}\").darwinConfigurations.Athena.options";
            user.expr = "(builtins.getFlake \"${flakeDir}\").packages.${system}.homeConfigurations.katie.options";
          };
        };
      };
      taplo.enable = true;
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
