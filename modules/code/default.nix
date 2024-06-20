{
  config,
  lib,
  ...
}: {
  imports = [
    ./codium
    ./lang

    ./git.nix
    ./shell.nix
  ];

  options = {
    code.enable = lib.mkEnableOption "code setup";
  };

  config = lib.mkIf config.code.enable {
    code = {
      git.enable = lib.mkDefault true;
      codium.enable = lib.mkDefault true;
      shell.enable = lib.mkDefault true;
    };
  };
}
