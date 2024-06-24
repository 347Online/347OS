{
  lib,
  config,
  pkgs,
  vscode-extensions,
  ...
}:
with vscode-extensions pkgs.vscode-extensions;
  lib.mkMerge [
    {
      programs.vscode.extensions =
        [
          # Essentials
          dbaeumer.vscode-eslint
          eamodio.gitlens
          mkhl.direnv
          ms-vsliveshare.vsliveshare
          ms-python.python

          # Formatting
          ms-python.black-formatter
          esbenp.prettier-vscode
          foxundermoon.shell-format
          bmalehorn.vscode-fish
          tamasfe.even-better-toml
          mechatroner.rainbow-csv
          open-vsx.yoavbls.pretty-ts-errors

          # Visuals
          pkief.material-icon-theme
          oderwat.indent-rainbow
          bradlc.vscode-tailwindcss

          # Utilities
          ritwickdey.liveserver
          vscode-marketplace.cweijan.vscode-database-client2
          ms-vscode.hexeditor
          asvetliakov.vscode-neovim
        ]
        ++ config.code.codium.extraExtensions;
    }
    (lib.mkIf config.code.codium.java
      {
        programs.vscode.extensions = [
          sonarsource.sonarlint-vscode
          redhat.java
          vscjava.vscode-java-test
          vscjava.vscode-java-debug
        ];
      })
  ]
