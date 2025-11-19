{
  flake.darwinModules.default =
    {
      config,
      lib,
      pkgs,
      username,
      util,
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
      ];

      darwin = {
        dock.email.enable = lib.mkDefault true;
        gui.enable = lib.mkDefault true;
        homebrew.enable = lib.mkDefault true;
      };

      environment = {
        enableAllTerminfo = true;
        systemPackages = [
          # System packages
          (pkgs.writeShellScriptBin "bundle-id" ''
            osascript -e "id of app \"$1\"" | tr -d '\n'
          '')
        ]
        ++ util.mkEssentials pkgs;
      };

      security.pam.services.sudo_local = {
        enable = true;
        touchIdAuth = true;
        watchIdAuth = true;
        reattach = true;
      };

      system = {
        primaryUser = username;
        defaults.dock = {
          show-recents = false;
          persistent-others = [ ];
          persistent-apps = [
            config.darwin.dock.browserAppPath
            (
              let
                cfg = config.darwin.dock.email;
              in
              lib.mkIf cfg.enable cfg.path
            )

            "/Applications/Fantastical.app"
            "/System/Applications/Music.app"
            "/Applications/Broadcasts.app"
          ]
          ++ config.darwin.dock.apps
          ++ [
            # Right-most apps
            "/Applications/Ghostty.app"
            "/System/Applications/System Settings.app"
          ];
        };
        startup.chime = true;

        activationScripts.postActivation.text = ''
          killall Dock
          /System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
        '';
      };

      home-manager.users.${username} = {
        # home.file = toHomeFiles ./dotfiles;
        # user.codium.enable = false; # Currently broken on aarch64-darwin?
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
    };
}
