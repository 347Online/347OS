{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (mdformat.withPlugins (ps: with ps; [ mdformat-frontmatter ]))
    eslint_d
    prettierd
    yamlfmt
    yamllint
  ];
}
