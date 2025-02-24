{
  config,
  lib,
  username,
  ...
}:
lib.mkIf config.nixos.gui.enable {
  home-manager.users.${username}.imports = [
    ./plasma.nix
  ];
}
