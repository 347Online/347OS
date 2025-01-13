{
  pkgs,
  ...
}:
{
  services.espanso = {
    enable = true;
    package = pkgs.espanso-wayland;

    matches = {
      base = {
        matches = [
          {
            replace = "‎ ";
            trigger = ";invis";
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
