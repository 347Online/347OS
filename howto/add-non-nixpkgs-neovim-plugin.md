# Add Non-nixpkgs Neovim Plugin

```nix
# flake.nix:mkNvim

pkgs = pkgs.extend (
  final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      final': prev': {
        nvim-emmet = prev.vimUtils.buildVimPlugin {
          pname = "nvim-emmet";
          version = inputs.nvim-emmet.shortRev;
          src = inputs.nvim-emmet;
        };
      }
    );
  }
);

```
