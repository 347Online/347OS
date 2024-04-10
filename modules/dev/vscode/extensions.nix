{
  pkgs,
  vscode-extensions,
  ...
}: {
  programs.vscode.extensions = with pkgs.vscode-extensions; [
    kamadorueda.alejandra
    oderwat.indent-rainbow
    # asvetliakov.vscode-neovim # Consider removing this, as it tends to be buggy
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
    sonarsource.sonarlint-vscode # TODO: Install or enable only on Alice host
    ms-vscode.live-server
    # ms-vsliveshare.vsliveshare # TODO: Figure out how to get this to build
  ];
}
