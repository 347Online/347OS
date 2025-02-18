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

      window-rules = [
        {
          description = "WezTerm";
          match = {
            window-class.value = "wezterm-gui";
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
        "networkmanagement.notifyrc" = {
          "Event/ConnectionActivated".Action = "";
          "Event/ConnectionDeactivated".Action = "";
        };

        kdeglobals.Shortcuts = {
          Copy = "Copy";
          Paste = "Paste";
          Cut = "Cut";
          Undo = "Undo";
        };
        plasmanotifyrc.Notifications = {
          PopupPosition = "TopRight";
        };
      };
    };
  };
}
