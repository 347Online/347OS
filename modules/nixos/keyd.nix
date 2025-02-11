{
  services.keyd = {
    enable = true;
    keyboards = {
      default = {
        ids = [ "*" ];
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
            tab = "swapm(app_switch_state, A-tab)";

            left = "home";
            right = "end";
            up = "C-home";
            down = "C-end";

            x = "cut";
            c = "copy";
            v = "paste";

            r = "refresh";
            z = "undo";

            # Focus Address Bar
            l = "A-d";
          };

          # Redo
          "meta_mac+shift".z = "C-y";

          "app_switch_state:A" = { };
        };
      };
    };
  };
}
