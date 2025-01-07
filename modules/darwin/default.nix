{
  config,
  lib,
  pkgs,
  username,
  ...
}:
let
  mkLoginItem = app: ''
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"${app}", hidden:true}'
  '';
in
{
  imports = [
    ./homebrew.nix
    ./nix.nix
    ./options.nix
    ./pam.nix
    ./prefs.nix
    ../shared/stylix.nix
  ];

  darwin.gui.enable = lib.mkDefault true;
  darwin.homebrew.enable = lib.mkDefault true;

  environment.systemPackages =
    let
      essentials = (import ../shared/programs/essentials.nix pkgs);
    in
    essentials
    ++ [
      # System packages
    ];

  # See ./pam.nix
  # security.pam.enableSudoTouchIdAuth = true;
  security.pam.enableCustomSudoTouchIdAuth = true;

  system = {
    defaults.dock.persistent-apps =
      with pkgs;
      [
        # System Apps
        "/System/Applications/App Store.app"
        (lib.mkIf (
          config.darwin.dock.browser == "Safari"
        ) "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app")
        (lib.mkIf (config.darwin.dock.browser == "Chrome") "/Applications/Google Chrome.app")
        (lib.mkIf (config.darwin.dock.browser == "Arc") "/Applications/Arc.app")
        (lib.mkIf (config.darwin.dock.browser == "Firefox") "/Applications/Firefox.app")
        "/System/Applications/Music.app"
        "/Applications/Broadcasts.app"
      ]
      ++ config.darwin.dock.apps
      ++ [
        "/Applications/Fantastical.app"
        "${wezterm}/Applications/wezterm.app"

        # Right-most apps
        "/System/Applications/System Settings.app"
        "/System/Applications/iPhone Mirroring.app"
      ];
    startup.chime = true;

    activationScripts.postActivation.text = ''
      killall Dock
    '';
  };

  home-manager.users.${username} = {
    # home.file = toHomeFiles ./dotfiles;
    home.packages = with pkgs; [ net-news-wire ];
  };

  programs = {
    zsh.enable = true;
    bash.enable = true;
  };

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 4;
}
