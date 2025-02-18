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

      configFile = {
        "networkmanagement.notifyrc" = {
          "Event/ConnectionActivated".Action = "";
          "Event/ConnectionDeactivated".Action = "";
        };
        kwinrulesrc =
          let
            apps = {
              wezterm = "ee5021f4-89ea-4fec-a2a3-8842ccf6cdd7";
            };
            appsList = builtins.attrValues apps;
          in
          {
            General = {
              count = builtins.length appsList;
              rules = lib.strings.concatStringsSep "," appsList;
            };
            ${apps.wezterm} = {
              Description = "Window settings for wezterm-gui";
              desktopfile = "${pkgs.wezterm}/share/applications/org.wezfurlong.wezterm.desktop";
              desktopfilerule = 2;
              types = 1;
              wmclass = "wezterm-gui";
              wmclassmatch = 1;
            };
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
