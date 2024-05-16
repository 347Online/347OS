{
  self,
  lib,
  pkgs,
  username,
  home-manager,
  nix-homebrew,
  dockApps,
  ...
}: {
  imports = [
    ./homebrew.nix
    ./nixConfig.nix
    home-manager.darwinModules.home-manager
    nix-homebrew.darwinModules.nix-homebrew
  ];

  # Misc config: # TODO: move to more sensible locations
  programs.git.extraConfig.credential.helper = "osxkeychain";
  services.nix-daemon.enable = true;
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";
  system.configurationRevision = self.rev or self.dirtyRev or null;
  nixpkgs.hostPlatform = "aarch64-darwin"; # TODO: Consider also enabling intel as an option

  homebrewSetup.enable = lib.mkDefault true;

  security.pam.enableSudoTouchIdAuth = true;

  environment.systemPackages = with pkgs; [
    monitorcontrol
  ];

  system = {
    startup.chime = true;

    defaults = {
      dock = {
        autohide = true;
        show-recents = false;
        persistent-apps = with pkgs;
          [
            # System Apps
            "/System/Applications/App Store.app"
            "/System/Volumes/Preboot/Cryptexes/App/System/Applications/Safari.app"
            "/System/Applications/Music.app"
          ]
          ++ dockApps
          ++ [
            "${obsidian}/Obsidian.app"
            "${vscodium}/VSCodium.app"
            "${kitty}/kitty.app"

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

      CustomSystemPreferences = {
        "com.apple.Safari" = {
          AutoOpenSafeDownloads = false;
          IncludeDevelopMenu = true;
          WebAutomaticSpellingCorrectionEnabled = false;
        };
      };

      CustomUserPreferences = {
        "com.pilotmoon.scroll-reverser" = {
          ReverseTrackpad = false;
          StartAtLogin = true;
          HideIcon = true;
          InvertScrollingOn = true;
          ReverseX = true;
        };

        "io.fadel.missioncontrolplus.preferences" = {
          HideMenubarItem = true;
        };

        "com.witt-software.Rocket-Typist-setapp" = {
          AbbreviationDelimiterKey = 1;
          AbbreviationsTriggerType = 1;
          AutoPasteEnabled = true;
          WelcomeViewHasBeenShown = true;
          ShowRTInMenuBar = false;
        };

        "com.apple.desktopservices" = {
          # Avoid creating .DS_Store files on network or USB volumes
          DSDontWriteNetworkStores = true;
          DSDontWriteUSBStores = true;
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

        "com.raycast.macos" = {
          raycastGlobalHotkey = "Command-49";
          useHyperKeyIcon = true;
          onboardingCompleted = true;
          "onboarding_setupHotkey" = true;
          "NSStatusItem Visible raycastIcon" = false;
          "emojiPicker_skinTone" = "standard";
        };
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
