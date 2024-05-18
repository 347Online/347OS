{
  config,
  lib,
  ...
}: {
  imports = [
    ./codium
    ./lang

    ./git.nix
    ./neovim.nix
    ./shell.nix
  ];

  options = {
    code.enable = lib.mkEnableOption "code setup";
  };

  config = lib.mkIf config.code.enable {
    gitSetup.enable = lib.mkDefault true;
    codium.enable = lib.mkDefault true;
    neovimSetup.enable = lib.mkDefault true;
    shellSetup.enable = lib.mkDefault true;
  };
}
