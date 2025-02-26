{
  pkgs,
  config,
  lib,
  username,
  ...
}:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
in
lib.mkIf config.user.gui.enable {
  programs.firefox = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    profiles.${username} = {
      search = {
        force = true;
        default = "Google (Fixed)";
        order = [
          "Google (Fixed)"
          "DuckDuckGo"
        ];
        engines = {
          Google.metaData.hidden = true;
          Bing.metaData.hidden = true;
          "Google (Fixed)" = {
            metaData.alias = "@google";
            urls = [
              {
                template = "https://www.google.com/search";
                params = [
                  {
                    name = "q";
                    value = "{searchTerms}";
                  }
                  {
                    name = "udm";
                    value = "14";
                  }
                ];
              }
            ];
          };
        };
      };

      extensions.packages = with firefox-addons; [
        darkreader
        onepassword-password-manager
        ublock-origin
        youtube-shorts-block
      ];

      settings = {
        "browser.uiCustomization.state" = builtins.toJSON rec {
          placements = {
            widget-overflow-fixed-list = [ ];
            "unified-extensions-area" = [
              "ublock0_raymondhill_net-browser-action"
              "_34daeb50-c2d2-4f14-886a-7160b24d66a4_-browser-action"
            ];
            nav-bar = [
              "back-button"
              "forward-button"
              "stop-reload-button"
              "urlbar-container"
              "downloads-button"
              "_d634138d-c276-4fc8-924b-40a0ea21d284_-browser-action"
              "addon_darkreader_org-browser-action"
            ];
            toolbar-menubar = [
              "menubar-items"
            ];
            TabsToolbar = [
              "alltabs-button"
              "tabbrowser-tabs"
              "new-tab-button"
            ];
            vertical-tabs = [ ];
            PersonalToolbar = [ "personal-bookmarks" ];
          };
          dirtyAreaCache = builtins.attrNames placements;
          currentVersion = 30;
        };

        "browser.aboutConfig.showWarning" = false;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.startup.page" = 3;
        "browser.tabs.inTitlebar" = 1;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.warnOnQuitShortcut" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "identity.sync.tokenserver.uri" = "https://firefox.fatgirl.cloud/1.0/sync/1.5";
        "signon.rememberSignons" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
      };
    };
  };
}
