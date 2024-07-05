{
  pkgs,
  lib,
  inputs,
  config,
  ...
}: {
  programs.firefox = {
    enable = lib.mkIf (!pkgs.stdenv.isDarwin) true;

    profiles.katie = {
      isDefault = true;
      extraConfig = ''
        user_pref("extensions.activeThemeID", "firefox-compact-dark@mozilla.org");
        user_pref("browser.startup.page", 3);
      '';
      extensions = with config.nur.repos.rycee.firefox-addons; [
        onepassword-password-manager
        darkreader
        youtube-shorts-block
        ublock-origin
      ];
    };
  };
}
