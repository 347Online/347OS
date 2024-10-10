{
  config,
  lib,
  util,
  isDarwin,
  ...
}: {
  imports = [
    ./codium
    ./firefox

    ./wezterm.nix
  ];

  programs.ssh.extraConfig =
    lib.mkIf (!config.__headless.enable)
    (util.mkIfElse
      isDarwin ''IdentityAgent "~/Library/Group Containers/2BUA8C4S2C.com.1password/t/agent.sock"'' "IdentityAgent ~/.1password/agent.sock");
}
