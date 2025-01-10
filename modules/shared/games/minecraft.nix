{
  lib,
  pkgs,
  config,
  ...
}:
lib.mkIf config.shared.gaming.enable {
  assertions = [
    {
      assertion = config.shared.personal.enable;
      message = "Gaming can only be enabled on personal devices.";
    }
  ];
  home.packages = with pkgs; [ prismlauncher ];
}
