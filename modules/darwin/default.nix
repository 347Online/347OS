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
    startup.chime = true;

    defaults = {
      dock = {
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

      NSGlobalDomain = {
        NSAutomaticCapitalizationEnabled = false;
        NSAutomaticSpellingCorrectionEnabled = false;
        NSAutomaticQuoteSubstitutionEnabled = false;
        NSAutomaticPeriodSubstitutionEnabled = false;
        NSAutomaticDashSubstitutionEnabled = false;
      };

      CustomUserPreferences = {
        "com.pilotmoon.scroll-reverser" = {
          ReverseTrackpad = false;
          StartAtLogin = true;
          InvertScrollingOn = true;
          ReverseX = true;
        };

        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
        };

        "com.apple.Safari" = {
          AutoOpenSafeDownloads = false;
          IncludeDevelopMenu = true;
          WebAutomaticSpellingCorrectionEnabled = false;
        };

        "com.apple.AdLib" = {
          allowApplePersonalizedAdvertising = false;
        };

        "com.apple.print.PrintingPrefs" = {
          # Automatically quit printer app once the print jobs complete
          "Quit When Finished" = true;
        };

        "com.apple.SoftwareUpdate" = {
          AutomaticCheckEnabled = true;
          ScheduleFrequency = 1;
          AutomaticDownload = 1;
          CriticalUpdateInstall = 1;
        };

        "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
        "com.apple.ImageCapture".disableHotPlug = true;
        "com.apple.commerce".AutoUpdate = true;
      };
    };
  };

  programs = {
    zsh.enable = true;
    bash.enable = true;
    fish.enable = true;
  };

  users.users."${username}" = {
    name = username;
    home = "/Users/${username}";
  };

  # DO NOT EDIT BELOW
  system.stateVersion = 4;
}
