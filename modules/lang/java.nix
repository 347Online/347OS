{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    lang.java.enable = lib.mkEnableOption "tooling catered to java development";
  };

  config = lib.mkIf config.lang.java.enable {
    code.codium.extraExtensions = with pkgs.vscode-extensions; [
      sonarsource.sonarlint-vscode
      redhat.java
      vscjava.vscode-java-test
      vscjava.vscode-java-debug
    ];

    home.packages = with pkgs; [
      jdk17
    ];
  };
}
