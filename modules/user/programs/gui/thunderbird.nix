{
  lib,
  config,
  ...
}:
lib.mkIf config.user.gui.enable {
  accounts.email.accounts.Personal.thunderbird = {
    enable = true;

    settings = id: {
      "mail.smtpserver.smtp_${id}.authMethod" = 10;
    };

    perIdentitySettings = id: {
      "mail.identity.id_${id}.archive_granularity" = 0;
      "mail.identity.id_${id}.archive_keep_folder_structure" = false;
      "mail.identity.id_${id}.archive_recreate_inbox" = false;

      "mail.identity.id_${id}.archive_folder" =
        let
          address = lib.escapeURL "katie@347Online.me";
        in
        "imap://${address}@imap.fastmail.com/Archive";
    };
  };

  programs.thunderbird = {
    enable = true;

    settings = {
      "mail.biff.play_sound" = false;
      "mail.biff.show_alert" = false;
      "mail.server.default.authMethod" = 0;
      "mail.smtpserver.default.authMethod" = 0;
      "mailnews.start_page.enabled" = false;
    };

    profiles = {
      main = {
        isDefault = true;
      };
    };
  };
}
