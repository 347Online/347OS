{
  system.keyboard = {
    enableKeyMapping = true;
    remapCapsLockToEscape = true;
  };

  system.defaults = {
    NSGlobalDomain = {
      NSAutomaticCapitalizationEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      AppleEnableSwipeNavigateWithScrolls = true;
      NSAutomaticInlinePredictionEnabled = false;
      ApplePressAndHoldEnabled = false;
      KeyRepeat = 2;
    };

    CustomSystemPreferences = {
      "com.apple.Safari" = {
        AutoOpenSafeDownloads = false;
        ShowFavoritesBar = true;
        IncludeDevelopMenu = true;
        WebAutomaticSpellingCorrectionEnabled = false;
        WebKitTabToLinksPreferenceKey = true;
      };
    };

    CustomUserPreferences = {
      NSGlobalDomain = {
        NSAutomaticSpellingCorrectionEnabled = false;
        # TODO: PR got merged, use the built-in option
        TSWPAutomaticSpellingCorrection = false;
      };

      "com.apple.messages.text".EmojiReplacement = 1;

      "com.apple.dock" = {
        wvous-br-corner = 4;
        wvous-br-modifier = 1048576;
        autohide = true;
        show-recents = false;
        showAppExposeGestureEnabled = true;
      };

      "com.apple.WindowManager" = {
        EnableStandardClickToShowDesktop = 0;
        HasDisplayedShowDesktopEducation = 1;
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

      "com.apple.symbolichotkeys" = {
        AppleSymbolicHotKeys = {
          "64".enabled = false;
          "65".enabled = false;
        };
      };

      "com.apple.TimeMachine".DoNotOfferNewDisksForBackup = true;
      "com.apple.ImageCapture".disableHotPlug = true;
      "com.apple.commerce".AutoUpdate = true;
      "com.apple.HIToolbox".AppleFnUsageType = 1;

      "com.pilotmoon.scroll-reverser" = {
        StartAtLogin = true;
        HideIcon = true;
        ReverseTrackpad = false;
        InvertScrollingOn = true;
        ReverseX = true;
      };

      "com.raycast.macos" = {
        raycastGlobalHotkey = "Command-49";
        useHyperKeyIcon = true;
        onboardingCompleted = true;
        "onboarding_setupHotkey" = true;
        "NSStatusItem Visible raycastIcon" = false;
        "emojiPicker_skinTone" = "standard";
      };

      # SetApp Apps
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

      "com.getcleanshot.app-setapp" = {
        afterScreenshotActions = [
          0
          1
          2
        ];
        afterVideoActions = [
          0
          1
          2
        ];
        analyticsAllowed = true;
        autoClosePopup = true;
        captureWithoutDesktopIcons = true;
        deletePopupAfterDragging = true;
        exportPath = "/Users/katie/Library/Mobile Documents/com~apple~CloudDocs/Files/Screenshots";
        freezeScreen = true;
        popupAskForDestinationWhenSaving = false;
        showMenuBarIcon = true;
      };
    };
  };
}
