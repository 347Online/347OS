{ lib, config, ... }:
lib.mkIf config.user.personal.enable (
  let
    userName = "katie@347online.me";
    passwordCommand = "op read 'op://Katie/Fastmail/App Password'";
  in
  {
    accounts = {
      calendar.accounts.Personal = {
        primary = true;
        remote = {
          inherit userName passwordCommand;
          type = "caldav";
          url = "caldav.fastmail.com";
        };
      };
      contact.accounts.Personal = {
        primary = true;
        remote = {
          inherit userName passwordCommand;
          type = "carddav";
          url = "carddav.fastmail.com";
        };
      };
      email.accounts.Personal = {
        inherit userName passwordCommand;
        realName = "Katie Janzen";
        address = "katie@347online.me";
        aliases = [ "katiejanzen@347online.me" ];
        primary = true;
        flavor = "fastmail.com";
      };
    };
  }
)
