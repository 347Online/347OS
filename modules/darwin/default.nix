{
  config,
  lib,
  pkgs,
  username,
  ...
}: let
  mkLoginItem = app: ''
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"${app}", hidden:true}'
  '';
in {
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./prefs.nix
    ../shared/stylix.nix
  ];

  options = with lib.types; {
    darwin.loginItems = lib.mkOption {
      type = listOf str;
      default = [];
    };
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
      defaults.dock.persistent-apps = with pkgs;
        [
          # System Apps
          "/System/Applications/App Store.app"
          (lib.mkIf (config.darwin.dock.browser == "Safari") "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app")
          (lib.mkIf (config.darwin.dock.browser == "Chrome") "/Applications/Google Chrome.app")
          "/System/Applications/Music.app"
        ]
        ++ config.darwin.dock.apps
        ++ [
          "/Applications/Fantastical.app"
          "${obsidian}/Applications/Obsidian.app"
          "${alacritty}/Applications/Alacritty.app"

          # Make system settings the rightmost app
          "/System/Applications/System Settings.app"
        ];
      startup.chime = true;

      activationScripts.postActivation.text = ''
        killall Dock
      '';
    };

    home-manager.users.${username} = {
      # home.file = toHomeFiles ./dotfiles;
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
