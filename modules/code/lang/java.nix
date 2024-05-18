{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    java.enable = lib.mkEnableOption "tooling catered to java development";
  };

  config = lib.mkIf config.java.enable {
    codium.extraExtensions = with pkgs.vscode-extensions; [
      sonarsource.sonarlint-vscode
      redhat.java
      vscjava.vscode-java-test
      vscjava.vscode-java-debug
    ];
  };
}
