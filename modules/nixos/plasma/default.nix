{
  config,
  lib,
  username,
  util,
  ...
}:
lib.mkIf config.nixos.gui.enable {
  home-manager.users.${username} = {
    home.file = util.toHomeFiles ./dotfiles;

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
