{
  programs.thunderbird = {
    enable = true;
  };

  accounts.email = {
    accounts.personal = {
      realName = "Katie Janzen";
      userName = "katie@347online.me";
      address = "katie@347online.me";
      imap.host = "imap.fastmail.com";
      smtp.host = "smtp.fastmail.com";
      primary = true;
      # TODO: This is NOT a good way to do this
      # Migrate to something like sops-nix and rotate this password
      passwordCommand = "~/.secrets/email/password-command.sh";
      thunderbird = {
        enable = true;
      };
    };
  };
}
