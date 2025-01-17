{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ]; # what goes into the [id] section, here we select all keyboard
        settings = {
          main = {
            capslock = "overload(control, esc)";
            leftmeta = "overload(meta_mac, leftmeta)";
            rightmeta = "overload(meta_mac, rightmeta)";
            leftalt = "overload(alt, leftalt)";
            rightalt = "overload(alt, rightalt)";
          };

          alt = {
            left = "C-left";
            right = "C-right";
            backspace = "C-backspace";
            delete = "C-delete";
          };

          "meta_mac:C" = {
            backspace = "macro(S-home 5ms backspace)";
            delete = "macro(S-end 5ms delete)";
            z = "undo";
            c = "copy";
            v = "paste";
            x = "cut";
            l = "A-d";
            r = "refresh";
            left = "home";
            right = "end";
            up = "C-home";
            down = "C-end";
            tab = "swapm(app_switch_state, A-tab)";
          };

          "meta_mac+shift".z = "C-y";

          "app_switch_state:A" = { };
        };
      };
    };
  };
}
