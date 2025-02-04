# Add Non-nixpkgs Neovim Plugin

```nix
# flake.nix:inputs

"<plugin>" = {
  url = "github:<owner>/<repo>[/branch|commit]";
  flake = false;
};

```

```nix
# flake.nix:mkNvim

pkgs = pkgs.extend (
  final: prev: {
    vimPlugins = prev.vimPlugins.extend (
      final': prev': {
        "<plugin>" = prev.vimUtils.buildVimPlugin {
          pname = "<plugin>";
          version = inputs."<plugin>".shortRev;
          src = inputs."<plugin>";
        };
      }
    );
  }
);

```
