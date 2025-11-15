{
  config,
  lib,
  username,
  ...
}:
lib.mkIf config.nixos.gui.enable {
  home-manager.users.${username}.imports = [
    ./elisa.nix
    ./plasma.nix
  ];
}
