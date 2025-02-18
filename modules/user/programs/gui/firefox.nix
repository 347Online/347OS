{
  pkgs,
  config,
  lib,
  username,
  homeDirectory,
  ...
}:
let
  profilePath =
    if pkgs.stdenv.isLinux then
      "${homeDirectory}/.mozilla/firefox/katie/"
    else
      "${homeDirectory}/Library/Application Support/Firefox/Profiles/katie/";
  ext._1password = "d634138d-c276-4fc8-924b-40a0ea21d284";
  extList = (builtins.attrNames ext) ++ [
    "addons-search-detection@mozilla.com"
    "default-theme@mozilla.org"
    "formautofill@mozilla.org"
    "pictureinpicture@mozilla.org"
    "screenshots@mozilla.org"
    "webcompat-reporter@mozilla.org"
    "webcompat@mozilla.org"
  ];
in
lib.mkIf config.user.gui.enable {
  # TODO: Extension preferences
  # home.file."${profilePath}/extensions-preferences.json".text = builtins.toJSON { };

  programs.firefox = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isDarwin null;

    profiles.${username} = {
      settings =
        let
        in
        {
          "browser.aboutConfig.showWarning" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.addons" = false;
          "browser.newtabpage.activity-stream.asrouter.userprefs.cfr.features" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.startup.page" = 3;
          "browser.tabs.inTitlebar" = 1;
          "browser.urlbar.suggest.quicksuggest.sponsored" = false;
          "browser.warnOnQuitShortcut" = false;
          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
          "identity.sync.tokenserver.uri" = "https://firefox.fatgirl.cloud/1.0/sync/1.5";
          "signon.rememberSignons" = false;

          # TODO: Programmatically for all relevant extensions
          "extensions.quarantineIgnoredByUser.{${ext._1password}}" = true;

          "browser.uiCustomization.state" = builtins.toJSON rec {
            placements = {
              widget-overflow-fixed-list = [ ];
              unified-extensions-area = [
                "ublock0_raymondhill_net-browser-action"
              ];
              nav-bar = [
                "back-button"
                "forward-button"
                "stop-reload-button"
                "urlbar-container"
                "downloads-button"
                "_${ext._1password}_-browser-action"
                "addon_darkreader_org-browser-action"
              ];
              toolbar-menubar = [
                "menubar-items"
              ];
              TabsToolbar = [
                "tabbrowser-tabs"
                "new-tab-button"
                "alltabs-button"
              ];
              vertical-tabs = [ ];
              PersonalToolbar = [ "personal-bookmarks" ];
            };
            dirtyAreaCache = builtins.attrNames placements;
            currentVersion = 20;
          };
        };

      # extensions = with config.nur.repos.rycee.firefox-addons; [
      #   darkreader
      #   onepassword-password-manager
      #   ublock-origin
      #   # youtube-shorts-block
      # ];
    };
  };
}
