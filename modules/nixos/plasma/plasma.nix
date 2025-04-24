{
  pkgs,
  config,
  lib,
  util,
  homeDirectory,
  ...
}:
lib.mkIf config.user.gui.enable {
  home.file = lib.mkMerge [
    (util.toHomeFiles ./dotfiles)
    {
      ".config/autostart/discord.desktop".enable = lib.mkIf (pkgs.system == "aarch64-linux") false;
    }
  ];

  programs.zsh.shellAliases.unfuck-plasma = ''
    qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "$(cat ${homeDirectory}/.local/share/plasma-manager/data/desktop_script_panels.js)"
  '';

  programs.plasma = {
    enable = true;
    overrideConfig = true;
    shortcuts = {
      plasmashell."activate application launcher" = [
        "Alt+F1,Meta"
        "Alt+F1,Activate Application Launcher"
      ];
    };

    krunner = {
      position = "center";
      activateWhenTypingOnDesktop = false;
      historyBehavior = "enableAutoComplete";
      shortcuts.launch = "Search";
    };

    kwin.effects.minimization.animation = "magiclamp";

    workspace = {
      colorScheme = "standardizeddark";
      cursor.theme = "breeze_cursors";
    };

    panels = [
      {
        height = 30;
        location = "top";
        floating = false;
        widgets = [
          {
            kicker = {
              settings.General.icon = "nix-snowflake-white";
            };
          }
          "org.kde.plasma.appmenu"
          "org.kde.plasma.panelspacer"
          {
            systemTray.items = {
              shown = [ ];
              hidden = [
                "org.kde.plasma.bluetooth"
                "org.kde.plasma.brightness"
                "org.kde.plasma.clipboard"
                "org.kde.plasma.networkmanagement"
                "org.kde.plasma.notifications"
                "org.kde.plasma.volume"
              ];
            };
          }
          {
            digitalClock = {
              calendar.firstDayOfWeek = "sunday";
              time.format = "12h";
              date.format.custom = "dddd MMM dd";
            };
          }
          "org.kde.plasma.notifications"
        ];
      }
      {
        height = 72;
        location = "bottom";
        hiding = "dodgewindows";
        lengthMode = "fit";
        floating = false;
        widgets = [
          {
            iconTasks = {
              launchers = [
                "preferred://filemanager"
                "preferred://browser"
                "preferred://mailer"
                "applications:org.kde.elisa.desktop"
                "preferred://terminal"
                "applications:systemsettings.desktop"
              ];
            };
          }
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.trash"
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
            value = "${pkgs.ghostty}/share/applications/com.mitchellh.ghostty.desktop";
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
          "TerminalApplication" = "com.mitchellh.ghostty.desktop";
        };
        Shortcuts = {
          Copy = "Copy";
          Paste = "Paste";
          Cut = "Cut";
          Undo = "Undo";
        };
      };
      kwinrc = {
        Effect-overview.BorderActivate = 9;
        ElectricBorders.BottomRight = "ShowDesktop";
        Windows.ElectricBorderCornerRatio = 0.1;
      };
      plasmanotifyrc.Notifications = {
        PopupPosition = "TopRight";
        PopupTimeout = 3000;
      };
    };
  };
}
