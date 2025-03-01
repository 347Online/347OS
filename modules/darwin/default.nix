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
    ./prefs.nix
    ../user/stylix.nix
  ];

  darwin.gui.enable = lib.mkDefault true;
  darwin.homebrew.enable = lib.mkDefault true;

  environment.systemPackages =
    let
      essentials = (import ../user/programs/essentials.nix pkgs);
    in
    essentials
    ++ [
      # System packages
    ];

  security.pam.services.sudo_local = {
    enable = true;
    touchIdAuth = true;
    reattach = true;
  };

  system = {
    defaults.dock.persistent-apps =
      [
        (lib.mkIf (
          config.darwin.dock.browser == "Safari"
        ) "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app")
        (lib.mkIf (config.darwin.dock.browser == "Chrome") "/Applications/Google Chrome.app")
        (lib.mkIf (config.darwin.dock.browser == "Arc") "/Applications/Arc.app")
        (lib.mkIf (config.darwin.dock.browser == "Firefox") "/Applications/Firefox.app")
        "/Applications/Thunderbird.app"
        "/Applications/Fantastical.app"
        "/System/Applications/Music.app"
        "/Applications/Broadcasts.app"
      ]
      ++ config.darwin.dock.apps
      ++ [
        "/Applications/Ghostty.app"

        # Right-most apps
        "/System/Applications/System Settings.app"
      ];
    startup.chime = true;

    activationScripts.postActivation.text = ''
      killall Dock
    '';
  };

  home-manager.users.${username} = {
    # home.file = toHomeFiles ./dotfiles;
    user.codium.enable = false; # Currently broken on aarch64-darwin?
    home.packages = with pkgs; [
      net-news-wire
    ];
  };

  programs = {
    zsh.enable = true;
    bash.enable = true;
  };

  users.users.${username} = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 5;
}
