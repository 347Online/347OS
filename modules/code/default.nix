{
  config,
  lib,
  ...
}: {
  imports = [
    ./vscode
    ./shell.nix
    ./git.nix

    ./neovim.nix
  ];

  options = {
    codeSetup.enable = lib.mkEnableOption "code setup";
  };

  config = lib.mkIf config.codeSetup.enable {
    gitSetup.enable = true;
    vscodeSetup.enable = true;
    neovimSetup.enable = true;
    shellSetup.enable = true;
  };
}
