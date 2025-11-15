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
          url = "https://caldav.fastmail.com";
        };
      };
      contact.accounts.Personal = {
        remote = {
          inherit userName passwordCommand;
          type = "carddav";
          url = "https://carddav.fastmail.com/dav/addressbooks/user/${userName}/Default";
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
