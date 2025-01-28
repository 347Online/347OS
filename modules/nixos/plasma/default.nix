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
