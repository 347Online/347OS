{ lib, config, ... }:
{
  accounts.email = {
    accounts.Personal = lib.mkIf config.user.personal.enable {
      realName = "Katie Janzen";
      userName = "katie@347online.me";
      address = "katie@347online.me";
      primary = true;
      flavor = "fastmail.com";
      passwordCommand = "op read 'op://Katie/Fastmail/App Password'";

      neomutt = {
        enable = true;
        mailboxType = "imap";
      };

      thunderbird = {
        enable = true;

        settings = id: {
          "mail.smtpserver.smtp_${id}.authMethod" = 10;
        };
      };
    };
  };
}
