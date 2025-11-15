{
  lib,
  config,
  ...
}:
{
  imports = [
    ./minecraft.nix
  ];

  config = lib.mkIf config.user.gaming.enable {
    assertions = [
      {
        assertion = config.user.gui.enable;
        message = "Gaming can only be enabled on GUI systems.";
      }
      {
        assertion = config.user.personal.enable;
        message = "Gaming can only be enabled on personal devices.";
      }
    ];
  };
}
