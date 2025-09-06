{
  config,
  pkgs,
  ...
}:
{
  programs.vscode.profiles.default.extensions =
    with pkgs.open-vsx;
    [
      # Essentials
      dbaeumer.vscode-eslint
      eamodio.gitlens
      mkhl.direnv
      pkgs.vscode-marketplace.ms-vsliveshare.vsliveshare
      ms-python.python
      jnoortheen.nix-ide

      # Formatting
      ms-python.black-formatter
      esbenp.prettier-vscode
      foxundermoon.shell-format
      bmalehorn.vscode-fish
      tamasfe.even-better-toml
      mechatroner.rainbow-csv
      yoavbls.pretty-ts-errors

      # Visuals
      pkief.material-icon-theme
      oderwat.indent-rainbow
      bradlc.vscode-tailwindcss

      # Utilities
      pkgs.open-vsx."1password".op-vscode
      ritwickdey.liveserver
      pkgs.vscode-marketplace.cweijan.vscode-database-client2
      ms-vscode.hexeditor
      vscodevim.vim
    ]
    ++ config.user.codium.extraExtensions;
}
