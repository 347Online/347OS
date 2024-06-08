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

  options = with lib.types; {
    darwin.dock = {
      browser = lib.mkOption {
        type = enum ["Chrome" "Safari"];
        default = "Safari";
      };
      apps = lib.mkOption {
        type = listOf str;
        default = [];
      };
    };
  };

  config = {
    darwin.homebrew.enable = lib.mkDefault true;

    security.pam.enableSudoTouchIdAuth = true;

    system = {
      startup.chime = true;

      # activationScripts.postActivation.text = ''
      #   killall Dock
      # '';
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
