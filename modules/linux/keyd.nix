{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboard
        settings = {
          main = {
            capslock = "overload(control, esc)";

            # Make Apple keyboards work the same way on KDE as they do on MacOS
            # Bind both "Cmd" keys to trigger the 'meta_mac' layer
            leftmeta = "layer(meta_mac)";
            rightmeta = "layer(meta_mac)";
          };

          # By default meta_mac = Ctrl+<key>, except for mappings below
          "meta_mac:C" = {
            # Use alternate Copy/Cut/Paste bindings from Windows that won't conflict with Ctrl+C used to break terminal apps
            # Copy (works everywhere (incl. vscode term) except Konsole)
            c = "C-insert";
            # Paste
            v = "S-insert";
            # Cut
            x = "S-delete";

            # Switch directly to an open tab (e.g., Firefox, VS Code)
            "1" = "A-1";
            "2" = "A-2";
            "3" = "A-3";
            "4" = "A-4";
            "5" = "A-5";
            "6" = "A-6";
            "7" = "A-7";
            "8" = "A-8";
            "9" = "A-9";

            # Move cursor to the beginning of the line
            left = "home";
            # Move cursor to the end of the line
            right = "end";

            # As soon as 'tab' is pressed (but not yet released), switch to the 'app_switch_state' overlay
            tab = "swapm(app_switch_state, A-tab)";
          };

          # Being in this state holds 'Alt' down allowing us to switch back and forth with tab or arrow presses
          "app_switch_state:A" = { };
        };
      };
    };
  };
}
