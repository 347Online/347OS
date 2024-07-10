{
  config,
  pkgs,
  vscode-extensions,
  ...
}: {
  programs.vscode.extensions = with vscode-extensions;
  with pkgs.vscode-extensions;
    [
      # Essentials
      dbaeumer.vscode-eslint
      eamodio.gitlens
      mkhl.direnv
      ms-vsliveshare.vsliveshare
      ms-python.python
      kamadorueda.alejandra
      jnoortheen.nix-ide

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
      # asvetliakov.vscode-neovim
      vscodevim.vim
    ]
    ++ config.code.codium.extraExtensions;
}
