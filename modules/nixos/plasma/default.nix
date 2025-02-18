{
  pkgs,
  config,
  lib,
  username,
  util,
  ...
}:
lib.mkIf config.nixos.gui.enable {
  home-manager.users.${username} = {
    home.file = lib.mkMerge [
      (util.toHomeFiles ./dotfiles)
      {
        ".config/autostart/discord.desktop".enable = lib.mkIf (pkgs.system == "aarch64-linux") false;
      }
    ];

    programs.plasma = {
      enable = true;
      overrideConfig = true;

      workspace.colorScheme = "standardizeddark";

      panels = [
        {
          height = 56;
          location = "bottom";
          widgets = [
            {
              kickoff = {
                sortAlphabetically = true;
                icon = "nix-snowflake-white";
              };
            }
            "org.kde.plasma.pager"
            {
              iconTasks = {
                launchers = [
                  "applications:systemsettings.desktop"
                  "applications:org.kde.dolphin.desktop"
                  "applications:firefox.desktop"
                  "applications:thunderbird.desktop"
                  "applications:org.wezfurlong.wezterm.desktop"
                ];
              };
            }
            "org.kde.plasma.marginsseparator"
            {
              systemTray.items = {
                shown = [ ];
                hidden = [ ];
              };
            }
            {
              digitalClock = {
                calendar.firstDayOfWeek = "sunday";
                time.format = "12h";
              };
            }
            "org.kde.plasma.showdesktop"
          ];
        }
      ];

      window-rules = [
        {
          description = "WezTerm";
          match = {
            window-class = {
              value = "wezterm-gui";
              match-whole = false;
            };
          };
          apply = {
            desktopfile = {
              value = "${pkgs.wezterm}/share/applications/org.wezfurlong.wezterm.desktop";
              apply = "force";
            };
          };
        }
      ];

      configFile = {
        kded5rc."Module-browserintegrationreminder"."autoload" = false;
        "networkmanagement.notifyrc" = {
          "Event/ConnectionActivated".Action = "";
          "Event/ConnectionDeactivated".Action = "";
        };
        kdeglobals = {
          General = {
            "TerminalApplication" = "wezterm start --cwd .";
            "TerminalService" = "org.wezfurlong.wezterm.desktop";
          };
          Shortcuts = {
            Copy = "Copy";
            Paste = "Paste";
            Cut = "Cut";
            Undo = "Undo";
          };
        };
        plasmanotifyrc.Notifications = {
          PopupPosition = "TopRight";
        };
      };
    };
  };
}
