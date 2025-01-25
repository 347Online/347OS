{
  config,
  lib,
  username,
  ...
}:
lib.mkIf config.nixos.gui.enable {
  home-manager.users.${username} = {
    programs.plasma = {
      enable = true;

      configFile = {
        kdeglobals = {
          Shortcuts = {
            Copy = "Copy";
            Paste = "Paste";
            Cut = "Cut";
            Undo = "Undo";
            #     Clear = "Meta+Backspace";
            #     Close = "Meta+W";
            #     CreateFolder = "Meta+Shift+N";
            #     DeleteWordBack = "Alt+Backspace";
            #     DeleteWordForward = "Alt+Del";
            #     Deselect = "Esc";
            #     Find = "Meta+F";
            #     MoveToTrash = "";
            #     New = "Meta+N";
            #     Open = "Meta+O";
            #     Paste = "Meta+V";
            #     PasteSelection = "";
            #     Print = "Meta+P";
            #     PrintPreview = "Meta+Shift+P";
            #     Save = "Meta+S";
            #     SaveAs = "Meta+Shift+S";
            #     SelectAll = "Meta+A";
            #     Spelling = "F7";
          };
        };
      };
    };
  };
}
