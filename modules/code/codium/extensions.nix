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
      esbenp.prettier-vscode
      eamodio.gitlens
      mkhl.direnv
      ms-vsliveshare.vsliveshare # Untested on aarch64-linux

      # Formatting
      foxundermoon.shell-format
      bmalehorn.vscode-fish
      tamasfe.even-better-toml
      mechatroner.rainbow-csv
      # TODO: Adjust the way things are setup here so nix-vscode-extensions can take priority over pkgs.vscode-extensions
      open-vsx.yoavbls.pretty-ts-errors

      # Visuals
      pkief.material-icon-theme
      oderwat.indent-rainbow

      # Do we really need two of these?
      ritwickdey.liveserver
      ms-vscode.live-server
    ]
    ++ config.code.codium.extraExtensions;
}
