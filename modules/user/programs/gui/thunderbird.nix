{
  lib,
  config,
  ...
}:
lib.mkIf config.user.gui.enable {
  programs.thunderbird = {
    enable = true;

    settings = {
      "mailnews.start_page.enabled" = false;
      "mail.server.default.authMethod" = 0;
      "mail.smtpserver.default.authMethod" = 0;
    };

    profiles = {
      main = {
        isDefault = true;
      };
    };
  };
}
