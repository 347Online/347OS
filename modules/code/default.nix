{
  config,
  lib,
  nixvim,
  ...
}: {
  imports = [
    ./vscode
    ./shell.nix
    ./git.nix

    nixvim
    ./neovim.nix
  ];

  options = {
    codeSetup.enable = lib.mkEnableOption "code setup";
  };

  config = lib.mkIf config.codeSetup.enable {
    gitSetup.enable = true;
    vscodiumSetup.enable = true;
    neovimSetup.enable = true;
    shellSetup.enable = true;
  };
}
