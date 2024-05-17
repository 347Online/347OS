{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    ./codium
    ./shell.nix
    ./git.nix
    ./rust.nix
    ./neovim.nix
  ];

  options = {
    code = {
      enable = lib.mkEnableOption "code setup";
      java.enable = lib.mkEnableOption "tooling catered to java development";
    };
  };

  config = lib.mkIf config.code.enable {
    gitSetup.enable = true;
    codium = {
      enable = true;
      extraExtensions = lib.mkIf config.code.java.enable (with pkgs.vscode-extensions; [
        sonarsource.sonarlint-vscode
        redhat.java
        vscjava.vscode-java-test
        vscjava.vscode-java-debug
      ]);
    };
    neovimSetup.enable = true;
    shellSetup.enable = true;
    rustSetup.enable = true;
  };
}
