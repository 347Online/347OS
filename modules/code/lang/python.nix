{
  config,
  lib,
  pkgs,
  vscode-extensions,
  ...
}: {
  options = {
    lang.python.enable = lib.mkEnableOption "python";
  };

  config = lib.mkIf config.lang.python.enable {
    code.codium.extraExtensions = with vscode-extensions;
    with pkgs.vscode-extensions; [
      ms-python.python
      ms-python.black-formatter
    ];
  };
}
