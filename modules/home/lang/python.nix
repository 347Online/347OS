{
  pkgs,
  vscode-extensions,
  ...
}: {
  code.codium.extraExtensions = with vscode-extensions;
  with pkgs.vscode-extensions; [
    ms-python.python
    ms-python.black-formatter
  ];
}
