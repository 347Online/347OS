{
  pkgs,
  config,
  lib,
  util,
  ...
}:
{
  imports = [
    ./codium

    ./espanso.nix
    ./messaging.nix
    ./thunderbird.nix
    ./wezterm.nix
  ];

  programs.ssh.extraConfig = lib.mkIf config.user.gui.enable (
    util.mkIfElse pkgs.stdenv.isDarwin
      "IdentityAgent \"~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock\""
      "IdentityAgent ~/.1password/agent.sock"
  );
}
