{
  pkgs,
  config,
  lib,
  username,
  ...
}:
let
  osDir = if pkgs.stdenv.isLinux then ".config" else throw "Library/Application Support????";
  extensions._1password = "d634138d-c276-4fc8-924b-40a0ea21d284";
  extList = (builtins.attrNames extensions) ++ [
    "addons-search-detection@mozilla.com"
    "default-theme@mozilla.org"
    "formautofill@mozilla.org"
    "pictureinpicture@mozilla.org"
    "screenshots@mozilla.org"
    "webcompat-reporter@mozilla.org"
    "webcompat@mozilla.org"
  ];
in
with extensions;
lib.mkIf config.user.gui.enable {
  home.file."${osDir}/.mozilla/firefox/${username}/extension-preferences.json".text =
    builtins.toJSON builtins.listToAttrs;

  programs.firefox = {
    enable = true;

    profiles.${username} = {
      settings =
        let
        in
        {
          "browser.aboutConfig.showWarning" = false;
          "browser.startup.homepage_override.mstone" = "ignore";
          "browser.startup.page" = 3;
          "browser.tabs.inTitlebar" = 1;
          "browser.warnOnQuitShortcut" = false;

          "extensions.quarantineIgnoredByUser.{${_1password}}" = true;

          "datareporting.policy.dataSubmissionPolicyBypassNotification" = true;
          "identity.sync.tokenserver.uri" = "https://firefox.fatgirl.cloud/1.0/sync/1.5";

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
                "_${_1password}_-browser-action"
                "addon_darkreader_org-browser-action"
                "unified-extensions-button"
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
