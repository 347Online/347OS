{
  pkgs,
  config,
  lib,
  username,
  ...
}:
let
  inherit (pkgs.nur.repos.rycee) firefox-addons;
  getBrowserAction =
    name:
    "${firefox-addons.${name}.addonId}-browser-action"
    |> lib.strings.stringAsChars (x: if (builtins.match "^[{}.@]$" x) != null then "_" else x)
    |> lib.strings.toLower;
in
lib.mkIf config.user.gui.enable {
  programs.firefox = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    profiles.${username} = {
      search = {
        force = true;
        default = "google-fixed";
        order = [
          "google-fixed"
          "ddg"
        ];
        engines = {
          google.metaData.hidden = true;
          bing.metaData.hidden = true;
          google-fixed = {
            name = "Google (Fixed)";
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
        instapaper-official
        onepassword-password-manager
        ublock-origin
        youtube-shorts-block
      ];

      settings = {
        "browser.uiCustomization.state" = builtins.toJSON rec {
          placements =
            let
              actions =
                [
                  "darkreader"
                  "instapaper-official"
                  "onepassword-password-manager"
                  "ublock-origin"
                  "youtube-shorts-block"
                ]
                |> builtins.map (name: {
                  inherit name;
                  value = (getBrowserAction name);
                })
                |> builtins.listToAttrs;
            in
            {
              widget-overflow-fixed-list = [ ];
              unified-extensions-area = [
                # This keeps ublock from pinning itself
                actions.ublock-origin
                actions.youtube-shorts-block
              ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "downloads-button"
                actions.onepassword-password-manager
                actions.instapaper-official
                actions.darkreader
              ]
              ++ config.user.firefox.extraPinnedItems;
              toolbar-menubar = [ "menubar-items" ];
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
        "browser.formfill.enable" = false;
        "browser.ml.chat.enabled" = false;
        "browser.ml.chat.menu" = false;
        "browser.ml.enable" = false;
        "browser.ml.linkPreview.enabled" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
        "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
        "browser.newtabpage.activity-stream.feeds.section.topstories" = false;
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredCheckboxes" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "browser.newtabpage.activity-stream.showWeather" = false;
        "browser.startup.homepage_override.mstone" = "ignore";
        "browser.startup.page" = 3;
        "browser.tabs.groups.smart.enabled" = false;
        "browser.tabs.groups.smart.userEnabled" = false;
        "browser.tabs.inTitlebar" = 1;
        "browser.toolbars.bookmarks.visibility" = "always";
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.warnOnQuitShortcut" = false;
        "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
        "extensions.autoDisableScopes" = 0;
        "extensions.formautofill.addresses.enabled" = false;
        "extensions.formautofill.creditCards.enabled" = false;
        "extensions.ml.enabled" = false;
        "sidebar.revamp" = false;
        "signon.rememberSignons" = false;
      };
    };
  };
}
