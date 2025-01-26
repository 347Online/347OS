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
