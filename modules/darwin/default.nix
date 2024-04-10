{
  pkgs,
  username,
  ...
}: {
  imports = [
    ./homebrew.nix
    ./nixConfig.nix
  ];

  security.pam.enableSudoTouchIdAuth = true;

  system = {
    defaults.dock = {
      autohide = true;
      show-recents = false;
      persistent-apps = [
        # System Apps
        "/System/Applications/App Store.app"
        "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
        "/System/Applications/Music.app"
        "/System/Applications/Messages.app"

        # Dev Tools
        "/${pkgs.vscodium}/Applications/VSCodium.app"
        "/${pkgs.kitty}/Applications/kitty.app"

        # Make system settings the rightmost app
        "/System/Applications/System Settings.app"
      ];
    };
  };

  programs.zsh.enable = true;
  programs.bash.enable = true;
  programs.fish.enable = true;

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 4;
}
