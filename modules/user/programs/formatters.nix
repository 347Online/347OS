{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.mdformat.withPlugins (
      ps: with ps; [
        mdformat-frontmatter
        mdformat-toc
        mdformat-tables
      ]
    ))
    eslint_d
    prettierd
    yamlfmt
    yamllint
  ];
}
