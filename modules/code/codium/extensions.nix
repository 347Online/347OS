{
  config,
  pkgs,
  vscode-extensions,
  ...
}: {
  programs.vscode.extensions = with vscode-extensions;
  with pkgs.vscode-extensions;
    [
      kamadorueda.alejandra
      oderwat.indent-rainbow
      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      eamodio.gitlens
      pkief.material-icon-theme
      ms-python.python
      ms-python.black-formatter
      mkhl.direnv
      thenuprojectcontributors.vscode-nushell-lang
      foxundermoon.shell-format
      jnoortheen.nix-ide
      bmalehorn.vscode-fish
      tamasfe.even-better-toml
      mechatroner.rainbow-csv
      ritwickdey.liveserver
      ms-vscode.live-server
      ms-vsliveshare.vsliveshare # TODO: Test on an aarch64-linux system
      rust-lang.rust-analyzer
      # TODO: Adjust the way things are setup here so nix-vscode-extensions can take priority over pkgs.vscode-extensions
      open-vsx.yoavbls.pretty-ts-errors
    ]
    ++ config.code.codium.extraExtensions;
}
