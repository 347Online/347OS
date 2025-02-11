{
  pkgs,
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
        }
      ];
  };

  programs.thunderbird = lib.mkMerge [
    (lib.mkIf pkgs.stdenv.isDarwin {
      darwinSetupWarning = false;
    })
    {
      enable = true;
      package = lib.mkIf pkgs.stdenv.isDarwin (
        pkgs.runCommand "thunderbird" { } ''
          mkdir $out
        ''
      );

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
    }
  ];
}
