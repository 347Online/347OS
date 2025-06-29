{
  pkgs,
  lib,
  config,
  util,
  ...
}:
let
  ids = {
    professional = "5c97026a5af6ad0f26987181ec12b552b33a4839794bde9497ff5540ec095f54";
    personal = "845f9286400f42697fbb196d24c794efa933ce1d20e2b93a7cf770b69f96f6fc";
  };
in
lib.mkIf (config.user.gui.enable && config.user.personal.enable) {
  accounts.calendar.accounts.Personal.thunderbird = {
    enable = lib.mkDefault true;
  };
  accounts.contact.accounts.Personal.thunderbird = {
    enable = lib.mkDefault true;
  };
  accounts.email.accounts.Personal.thunderbird = {
    enable = lib.mkDefault true;

    settings =
      id: with ids; {
        "mail.smtpserver.smtp_${id}.authMethod" = 10;
        "mail.identity.id_${professional}.label" = "Professional";
        "mail.identity.id_${personal}.label" = "Personal";
      };

    messageFilters = [
      {
        name = "Mark as Read on Archive";
        type = "128";
        action = "Mark read";
        condition = "ALL";
      }
    ];

    perIdentitySettings =
      id:
      let
        mkFolder =
          folder: symbol: pluralize:
          let
            folder' = "imap://${lib.escapeURL "katie@347online.me"}@imap.fastmail.com/${folder}";
          in
          lib.mkMerge [
            {
              "mail.identity.id_${id}.${symbol}_folder" = folder';
              "mail.identity.id_${id}.${symbol}_folder_picker_mode" = "1";
            }
            (lib.mkIf pluralize {
              "mail.identity.id_${id}.${symbol}s_folder" = folder';
              "mail.identity.id_${id}.${symbol}s_folder_picker_mode" = "1";
            })
          ];
      in
      lib.mkMerge [
        (mkFolder "Archive" "archive" true)
        (mkFolder "Drafts" "draft" true)
        (mkFolder "Sent" "fcc" false)
        {
          "mail.identity.id_${id}.archive_granularity" = 0;
          "mail.identity.id_${id}.archive_keep_folder_structure" = false;
          "mail.identity.id_${id}.archive_recreate_inbox" = false;

          "mail.server.server_${id}.ageLimit" = 30;
          "mail.server.server_${id}.applyToFlaggedMessages" = false;
          "mail.server.server_${id}.autosync_max_age_days" = 30;
          "mail.server.server_${id}.cleanupBodies" = false;
          "mail.server.server_${id}.daysToKeepBodies" = 30;
          "mail.server.server_${id}.daysToKeepHdrs" = 30;
          "mail.server.server_${id}.downloadByDate" = false;
          "mail.server.server_${id}.downloadUnreadOnly" = false;
          "mail.server.server_${id}.numHdrsToKeep" = 2000;
        }
      ];
  };

  programs.thunderbird = lib.mkMerge [
    {
      enable = true;

      settings = {
        "mail.biff.play_sound" = false;
        "mail.biff.show_alert" = false;
        "mail.prompt_purge_threshold" = true;
        "mail.purge.ask" = false;
        "mail.shell.checkDefaultClient" = true;
        "mailnews.start_page.enabled" = false;
      };

      profiles = {
        main = {
          isDefault = true;
        };
      };
    }
  ];
}
