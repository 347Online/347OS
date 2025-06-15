{ pkgs, ... }:
{
  home.packages = with pkgs; [
    (pkgs.mdformat.withPlugins (
      ps: with ps; [
        mdformat-beautysh
        mdformat-footnote
        mdformat-frontmatter
        mdformat-tables
        # mdformat-toc
      ]
    ))
    eslint_d
    prettierd
    shellcheck
    shfmt
    sqlfluff
    stylua
    yamlfmt
    yamllint
  ];
}
