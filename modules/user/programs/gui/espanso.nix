{
  pkgs,
  lib,
  ...
}:
{
  services.espanso = {
    enable = true;
    package = lib.mkIf pkgs.stdenv.isLinux pkgs.espanso-wayland;

    configs.default.show_notifications = false;

    matches = {
      base = {
        matches = [
          {
            replace = "{{today}}";
            trigger = ";tod";
            vars = [
              {
                name = "today";
                type = "date";
                params.format = "%m/%d/%Y";
              }
            ];
          }
          {
            replace = "‎ ";
            trigger = ";invis";
          }
          {
            replace = "she/her/hers";
            trigger = ";pro";
          }
          {
            replace = "katiejanzen@347online.me";
            trigger = ";pem";
          }
          {
            replace = "Katie Janzen";
            trigger = ";n";
          }
          {
            replace = "Katie";
            trigger = ";fn";
          }
          {
            replace = "Janzen";
            trigger = ";ln";
          }
          {
            replace = "Full Stack Software Engineer";
            trigger = ";hl";
          }
          {
            replace = "https://github.com/347Online";
            trigger = ";gh";
          }
          {
            replace = "https://www.linkedin.com/in/katie-janzen/";
            trigger = ";li";
          }
          {
            replace = "https://347online.me";
            trigger = ";ws";
          }
          {
            replace = "accessibility";
            trigger = "a11y";
          }
          {
            replace = "💀";
            trigger = ":skull:";
          }
        ];
      };
    };
  };
}
