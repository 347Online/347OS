{
  lib,
  pkgs,
  username,
  ...
}: {
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./prefs.nix
  ];

  options = {
    darwin.dockApps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [];
    };
  };

  config = {
    darwin.homebrew.enable = lib.mkDefault true;

    security.pam.enableSudoTouchIdAuth = true;

    system = {
      startup.chime = true;

      activationScripts.postActivation.text = ''
        killall Dock
      '';
    };

    programs = {
      zsh.enable = true;
      bash.enable = true;
      fish.enable = true;
    };

    environment.systemPackages = with pkgs; [
      monitorcontrol
    ];

    users.users."${username}" = {
      name = username;
      home = "/Users/${username}";
    };

    # DO NOT EDIT BELOW
    system.stateVersion = 4;
  };
}
